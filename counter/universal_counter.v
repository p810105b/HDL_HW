module universal_counter (clear, mode, incr, pause, clk, count); 
input clear; /* if clear = 1, count[3:0] is reset at the positive edge of the clock*/ 
input mode; /* hexadecimal cpounting if mode = 1, decimal counting if otherwise */ 
input incr; /* up counting if incr = 1, down counting if incr = 0 */ 
input pause; /* counting suspended when pause = 1 */ 
input clk; 
output [3:0] count; /* counter output */ 
reg [3:0] count; /* register type variable */ 
/* priority of control signals: clear > pause */


always@(posedge clk) begin
	if(clear) 
		count <= 4'h0;
	else if(pause) 
		count <= count;
	else begin
		case(mode)
			1'b0 : begin // decimal counting
				if(incr == 1)  // up counting
					count <= (count == 9) ? 4'd0 : count + 4'd1;
				else // down counting
					count <= (count == 0) ? 4'd9 : count - 4'd1;
			end
			1'b1 : begin // hexadecimal counting
				if(incr == 1)  // up counting
					count <= count + 4'h1;
				else // down counting
					count <= count - 4'h1;
			end
			default : count <= 1'b0;
		endcase
	end
end


endmodule
