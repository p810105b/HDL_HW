module D_FF1(q, din, clk, rst);

output q;
input din, clk, rst;

reg q; /* variable type declaration plus initial value setting */

always @(negedge clk) begin	/* synchronous and active high reset, negative clock edge triggering*/
	if (!rst)
		q <= 1'b0;  		/*synchronous,active high*/
	else
		q <= din;
end
		
endmodule 
