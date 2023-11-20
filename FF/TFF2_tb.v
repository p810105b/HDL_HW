module T_FF2_tb();

reg clk,rst;
wire q;

T_FF2 unit2(.q(q), .clk(clk), .rst(rst)); // design instantiation

initial clk = 1'b0; // stimulus block for (a) waveforms

always #10 clk = ~clk; // flip the clk value every 10 time units

initial begin
		rst = 1'b1;
	#15 rst = 1'b0;
	#8 	rst = 1'b1;
	
	#38 $finish;
end 

endmodule
