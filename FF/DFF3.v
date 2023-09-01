module D_FF3(q, din, clk, enable);
output q;
input din, clk, enable;
reg q = 1'b0; /* variable type declaration plus initial value setting */
/* asynchronous and active high reset, positive clock edge triggering*/
always @(negedge clk)
 if (enable)
	q <= din;
endmodule 
