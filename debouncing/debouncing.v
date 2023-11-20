module debouncing(clk, sig_in, sig_out); 

input clk; 
input sig_in; 

output reg sig_out; 

parameter IDLE			  = 3'd0;
parameter OUTPUT_ZERO     = 3'd1;
parameter FIRST_SAMPLE_1  = 3'd2;
parameter SECOND_SAMPLE_1 = 3'd3;

parameter OUTPUT_ONE      = 3'd4;
parameter FIRST_SAMPLE_0  = 3'd5;
parameter SECOND_SAMPLE_0 = 3'd6;

reg [2:0] state, next_state;

always@(posedge clk) begin
	if(reset) begin
		state <= IDLE
	end
	else begin
		state <= next_state;
	end
end

always@(*) begin                 
	case(state)
		IDLE			: next_state = (sig_in == 1'b0) ?  OUTPUT_ZERO : OUTPUT_ONE;
		// current : 0
		OUTPUT_ZERO     : next_state = (sig_in == 1'b0) ?  OUTPUT_ZERO : FIRST_SAMPLE_1;
		FIRST_SAMPLE_1  : next_state = (sig_in == 1'b0) ?  OUTPUT_ZERO : SECOND_SAMPLE_1;
		SECOND_SAMPLE_1 : next_state = (sig_in == 1'b0) ?  OUTPUT_ZERO : OUTPUT_ONE;
		// current : 1
		OUTPUT_ONE      : next_state = (sig_in == 1'b1) ?  OUTPUT_ONE : FIRST_SAMPLE_0;
		FIRST_SAMPLE_0  : next_state = (sig_in == 1'b1) ?  OUTPUT_ONE : SECOND_SAMPLE_0;
		SECOND_SAMPLE_0 : next_state = (sig_in == 1'b1) ?  OUTPUT_ONE : OUTPUT_ZERO;
		default 		: next_state = IDLE;
	endcase
end 

always@(*) begin
	case(state)
		IDLE			: sig_out = (sig_in == 1'b0) ? 1'b0 : 1'b1;
		// current : 0
		OUTPUT_ZERO     : sig_out = 1'b0;
		FIRST_SAMPLE_1  : sig_out = 1'b0;
		SECOND_SAMPLE_1 : sig_out = 1'b0;
		// current : 1    
		OUTPUT_ONE      : sig_out = 1'b1;
		FIRST_SAMPLE_0  : sig_out = 1'b1;
		SECOND_SAMPLE_0 : sig_out = 1'b1;
		default 		: sig_out = 1'b0;
	endcase
end

endmodule 