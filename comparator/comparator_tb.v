`timescale 1ns/1ps
module comparator_tb;

reg [15:0] a, b;
wire a_gt_b, a_eq_b, a_lt_b;

comparator comparator(.a(a), .b(b), .a_gt_b(a_gt_b), .a_eq_b(a_eq_b), .a_lt_b(a_lt_b));

initial begin
	a = 16'h04F8;
	b = 16'h04f7;
	
	#10 
	b = 16'h04FA;
	
	#10 
	a = 16'h04FA;
	
	#10 
	b = 16'h24FA;
	
	#20 
	$finish;
end
endmodule
