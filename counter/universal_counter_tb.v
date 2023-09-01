`timescale 1ns/1ps
module universal_counter_tb;

reg clk;
reg clear;
reg pause;
reg mode;
reg incr;
wire [3:0]count;

universal_counter universal_counter(.clear(clear), 
									.mode(mode), 
									.incr(incr), 
									.pause(pause), 
									.clk(clk), 
									.count(count));


always #5 clk = ~clk; // flip the clk value every 5 time units
	
initial begin
// initial values//
	clk   <= 1'b0;
	clear <= 1'b1;
	pause <= 1'b0;
	mode  <= 1'b0;
	incr  <= 1'b1;
//signal//
	#20  
	clear  <=1'b0;
	#60  
	pause  <=1'b1;
	#30  
	pause  <=1'b0;
	incr   <=1'b0;
	#60  
	clear  <=1'b1;
	#10  
	clear  <=1'b0;
	mode   <=1'b1;
	incr   <=1'b1;
	#60  
	incr   <=1'b0;
	#20  
	incr   <=1'b1;
	#140 
	pause  <=1'b0;
	
	#0  
	$finish;
end
		
endmodule