module D_FF1_tb;

reg clk,rst,d;
wire q;

D_FF1 unit1(.q(q), .din(d), .clk(clk), .rst(rst)); // design instantiation

initial clk = 1'b1; // stimulus block for (a) waveforms
	
always #10 clk = ~clk; // flip the clk value every 10 time units

initial begin
	rst = 1'b0;
	d 	= 1'b0;
	
	#7 	d = 1'b1;
	
	#15 rst = 1'b1;
	
	#3 	d = 1'b0;
	#10 d = 1'b1;
	#3 	d = 1'b0;
	
	#1 	rst = 1'b0;
	
	#6 	d = 1'b1;
	#8 	d = 1'b0;
	
	#8 	$finish;
end
 
endmodule
