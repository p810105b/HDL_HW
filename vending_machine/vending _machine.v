module vending_machine(clk, reset, item, sel, dollar_10, dollar_50, price, item_rels, change_return); 
input 		clk; 
input 		reset; 		/* active high, synchronous reset*/ 
input [1:0] item; 		/* item selection, transition @ negedge(clk) */ 
input 		sel; 		/* confirm the selection, active high, transition @ negedge(clk) */ 
input 		dollar_10; 	/* valid for 1 clock cycle, transition @ negedge(clk) */ 
input 		dollar_50; 	/* valid for 1 clock cycle, transition @ negedge(clk) */ 

output reg signed [3:0] price; 			/* always valid, refer to Table 2, transition @ posedge(clk) */ 
output reg 		  [2:0] item_rels; 		/* refer to Table 3, transition @ posedge(clk) */ 
output reg 		 		change_return; 	/* one clock cycle for one coin return, transition @ posedge(clk) */ 

// items encoding
localparam WATER 	= 2'b00;
localparam TEA 		= 2'b01;
localparam COKE 	= 2'b10;
localparam JUICE 	= 2'b11;

localparam PRICE_WATER 	= 4'b0010;
localparam PRICE_TEA 	= 4'b0011;
localparam PRICE_COKE 	= 4'b0100;
localparam PRICE_JUICE 	= 4'b0101;

reg [1:0] item_reg;

// The lastest selected item
always@(posedge clk) begin
	if(reset) begin
		item_reg <= WATER;
	end
	else if(sel) begin
		item_reg <= item;
	end
end

// price
wire signed [3:0] selected_item_price = (item == WATER)? PRICE_WATER 	:
										(item == TEA)  ? PRICE_TEA 		:	
										(item == COKE) ? PRICE_COKE		:
										(item == JUICE)? PRICE_JUICE 	: 4'd0;

always@(posedge clk) begin
	if(reset) begin
		price <= 4'd0;
	end
	else if(sel == 1'b1)begin
		price <= selected_item_price;
	end
	else if(dollar_10) begin
		price <= price - 4'd1;
	end
	else if(dollar_50) begin
		price <= price - 4'd5;
	end
	else if(price < 4'sd0) begin
		price <= price + 4'd1;
	end
end


// item release
always@(posedge clk) begin
	if(reset) begin
		item_rels <= 3'b000;
	end
	else if((price <= 4'd1 && dollar_10) || (price <= 4'd5 && dollar_50)) begin
		item_rels <= {1'b1, item_reg};
	end
	else if(item_rels != 3'b000) begin
		item_rels <= 3'b000;
	end
end

// change return
always@(posedge clk) begin
	if(reset) begin
		change_return <= 1'b0;
	end
	else if(price < 4'sd0) begin
		change_return <= 1'b1;
	end
	else begin
		change_return <= 1'b0;
	end
end

endmodule
