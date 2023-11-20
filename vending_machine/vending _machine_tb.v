`timescale 1ns/1ps
module vending_machine_tb;

reg clk, reset, dollar_10, dollar_50, sel;
reg [1:0] item;

wire [3:0] price;
wire [2:0] item_rels;
wire change_return;

vending_machine vending_machine(.clk(clk), 
								.reset(reset), 
								.item(item), 
								.sel(sel), 
								.dollar_10(dollar_10), 
								.dollar_50(dollar_50), 
								.price(price), 
								.item_rels(item_rels), 
								.change_return(change_return)
								);

always #5 clk = ~clk;

initial begin
	clk       <= 1'b0;
	reset     <= 1'b0;
	item      <= 2'b00;
	sel       <= 1'b0;
	dollar_10 <= 1'b0;
	dollar_50 <= 1'b0;
end

initial begin
	reset <= #5   1'b1;
	reset <= #15  1'b0;
	reset <= #305 1'b1;
	reset <= #315 1'b0;
	
	item  <= #25  2'b01;
	item  <= #35  2'b10;
	item  <= #45  2'b11;
	item  <= #55  2'b00;
	item  <= #145 2'b01;
	item  <= #155 2'b00;
	item  <= #175 2'b11;
	item  <= #185 2'b00;
	item  <= #245 2'b10;
	item  <= #255 2'b11;
	item  <= #265 2'b10;
	item  <= #275 2'b00;
	
	sel   <= #25  1'b1;
	sel   <= #45  1'b0;
	sel   <= #145 1'b1;
	sel   <= #155 1'b0;
	sel   <= #255 1'b1;
	sel   <= #265 1'b0;
	
	dollar_10 <= #55  1'b1;
	dollar_10 <= #85  1'b0;
	dollar_10 <= #155 1'b1;
	dollar_10 <= #175 1'b0;
	dollar_10 <= #185 1'b1;
	dollar_10 <= #195 1'b0;
	dollar_10 <= #265 1'b1;
	dollar_10 <= #275 1'b0;
	
	dollar_50 <= #85  1'b1;
	dollar_50 <= #95  1'b0;
	dollar_50 <= #205 1'b1;
	dollar_50 <= #215 1'b0;
	dollar_50 <= #275 1'b1;
	dollar_50 <= #285 1'b0;
	
	#350 $finish;
end

endmodule
