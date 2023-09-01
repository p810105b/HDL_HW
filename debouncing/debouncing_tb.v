`timescale 1ns/1ps
module debouncing_tb;

reg clk, sig_in;
wire sig_out;

debouncing debouncing(.clk(clk), .sig_in(sig_in), .sig_out(sig_out));

always #5 clk = ~clk;

initial clk    <= 1'b0;
	
initial 
begin
	sig_in <= #0  1'b0;
	sig_in <= #8  1'b1;
	sig_in <= #11 1'b0;
	sig_in <= #14 1'b1;
	sig_in <= #17 1'b0;
	sig_in <= #21 1'b1;
	sig_in <= #24 1'b0;
	sig_in <= #27 1'b1;
	sig_in <= #73 1'b0;
	sig_in <= #76 1'b1;
	sig_in <= #79 1'b0;
	sig_in <= #83 1'b1;
	sig_in <= #86 1'b0;
	sig_in <= #88 1'b1;
	sig_in <= #91 1'b0;
	#200 $finish;
end

endmodule	