`timescale 1ns/1ps
module vending_machine(clk, reset, item, sel, dollar_10, dollar_50, price, Release, change_return);
input clk;
input reset;     	  // active high, synchronous reset
input [1:0] item;  	  // item selection 
input sel; 		  	  // confirm the selection valid
input dollar_10;      // valid for 1 clock cycle 
input dollar_50; 	  // valid for 1 clock cycle 
output [3:0] price;   // refer to Table 
output [2:0] Release; // refer to Table 
output change_return; // one clock cycle for one coin return , 1 for valid return cycle

// Register for FSM
reg [3:0] price, next_price;
reg [2:0] next_product_release, Release;
reg change_return, next_change_return;
reg [1:0] pre_item;

// Next state logic
always@(posedge clk)begin
	if(reset) begin
		Release         <= 3'b000;
		price           <= 4'b0000;
		change_return   <= 1'b0;
		next_product_release <= 3'b000;
		next_change_return   <= 1'b0; 
		next_price           <= 4'b0000;
	end
	else begin
		price           <= next_price;
		change_return   <= next_change_return;
		Release 		<= next_product_release;
		next_product_release <= 3'b000;
	end
end

// Combination logic for item prices
always@ (item or sel) begin
	if(sel) begin
		case(item)
			2'b00: begin // water
				next_price <= 4'b0010; // $20
				pre_item   <= 2'b00;
			end
			2'b01: begin // tea
				next_price <= 4'b0011; // $30
				pre_item   <= 2'b01;
			end
			2'b10: begin // coke
				next_price <= 4'b0100; // $40
				pre_item   <= 2'b10;
			end
			2'b11: 	begin // juice
				next_price <= 4'b0101; // $50
				pre_item   <= 2'b11;
			end
			default: begin
				next_price <= 4'b0000; 
				pre_item   <= 2'b00;
			end
		endcase
	end
end

// initial states 
always@ (price <= 4'b0000 or Release <= 3'b000 or change_return <= 1'b0)begin
	case(pre_item)
		2'b00:  next_product_release <= 3'b100;
		2'b01:  next_product_release <= 3'b101;
		2'b10:  next_product_release <= 3'b110;
		2'b11:  next_product_release <= 3'b111;
		default:next_product_release<= 3'b000;
	endcase
end
	
// change return control 
always@ (negedge clk)begin
	case(price)
		// change return ; positive value for need , negative value for return
		4'b1100 : begin // $ -40
					next_price = 4'b1101; // -$30
					next_change_return = 1'b1;
		end
		4'b1101 : begin // $ -30
					next_price = 4'b1110;// -$20
					next_change_return = 1'b1;
		end
		4'b1110 : begin // $ -20
					next_price = 4'b1111; // -$10
					next_change_return = 1'b1;
		end	 
		4'b1111 : begin // $ -10
					next_price = 4'b0000; //  $0
					next_change_return = 1'b1;
		end
		// insert change $10 or $50
		4'b0000 : begin
					next_change_return <= 1'b0;
					if(dollar_10) begin
						case(pre_item)
							3'b100: next_price <= 4'b0001; // water $20 - $10 = $10
							3'b101: next_price <= 4'b0010; // tea   $30 - $10 = $20
							3'b110: next_price <= 4'b0011; // coke  $40 - $10 = $30
							3'b111: next_price <= 4'b0100; // juice $50 - $10 = $40
							default:next_price <= 4'b0000;
						endcase
					end
					else if(dollar_50)begin
						case(pre_item)
							2'b00: next_price  <= 4'b1101; // water $20 - $50 = -$30											
							2'b01: next_price  <= 4'b1110; // tea   $30 - $50 = -$20
							2'b10: next_price  <= 4'b1111; // coke  $40 - $50 = -$10
							2'b11: next_price  <= 4'b0000; // juice $50 - $50 =  $0
							default:next_price <= 4'b0000;
						endcase
					end
		end
		4'b0001 : begin
					if(dollar_10) begin
						next_price    <= 4'b0000; // $10 - $10 = $0
						price         <= 4'b0000;
						change_return <= 1'b0;
					end
					else if(dollar_50) begin
						next_price    <= 4'b1100; // $10 - $50 = -$40
						price         <= 4'b0000;
						change_return <= 1'b0;
					end
		end
		4'b0010 : begin
					if(dollar_10) 
						next_price    <= 4'b0001; // $20 - $10 = $10
					else if(dollar_50) begin
						next_price    <= 4'b1101;
						price         <= 4'b0000; // $20 - $50 = -$30
						change_return <=1'b0;
					end
		end
		4'b0011 : begin
					if(dollar_10)
						next_price <= 4'b0010; // $30 - $10 = $20
					else if(dollar_50)begin
						next_price <= 4'b1110; // $30 - $50 = -$20
						price        <=4'b0000;
						change_return<=1'b0;
					end
		end
		4'b0100 : begin
					if(dollar_10)
						next_price <= 4'b0011; // $40 - $10 = $30
					else if(dollar_50)begin
						next_price <= 4'b1111; // $40 - $50 = -$10
						price        <=4'b0000;
						change_return<=1'b0;
					end
		end
		4'b0101 : begin
					if(dollar_10)
						next_price <= 4'b0100; // $50 - $10 = $40
					else if(dollar_50) begin
						next_price <= 4'b0000; // $50 - $50 = $0
						price        <=4'b0000;
						change_return<=1'b0;
					end
		end
	endcase
end		

endmodule