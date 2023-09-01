module T_FF2(q, clk, rst);
output q;
input clk, rst;
reg q = 1'b0; /* variable type declaration plus initial value setting */
/* asynchronous and active low reset, positive clock edge triggering*/
always @(negedge rst or posedge clk)
	if (~rst)
		q <= 1'b0;
	else
		q <= ~q;
endmodule 