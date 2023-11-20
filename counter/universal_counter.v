module universal_counter (clear, mode, incr, pause, clk, count);

input clear; 			/* if clear = 1, count[3:0] is reset at the positive edge of the clock*/
input mode; 			/* hexadecimal counting if mode = 1, decimal counting if otherwise */
input incr; 			/* up counting if incr = 1, down counting if incr = 0 */
input pause; 			/* counting suspended when pause = 1 */
input clk;
output reg [3:0] count; /* counter output, register type variable */

always @(posedge clk) begin
	if(clear) begin
		count <= 4'd0;
	end
	// if pause=1,the counter will stop
	else if(~pause) begin
		// count in hexidecimal
		if(mode) begin
			if(incr) 
				count <= count + 4'd1;
			else
				count <= count - 4'd1;
		end
		// count in decimal
		else begin 
			if(incr) 
				count <= (count == 4'd9) ? 4'd0 : (count + 1'd1); 
			else
				count <= (count == 4'd0) ? 4'd9 : (count - 1'd1); 
		end	
	end
end

endmodule
