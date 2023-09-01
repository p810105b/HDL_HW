module debouncing(clk, sig_in, sig_out); 
input clk; 
input sig_in; 
output reg sig_out; 

parameter IDLE			  = 0;
parameter OUTPUT_ZERO     = 1;
parameter FIRST_SAMPLE_1  = 2;
parameter SECOND_SAMPLE_1 = 3;

parameter OUTPUT_ONE      = 4;
parameter FIRST_SAMPLE_0  = 5;
parameter SECOND_SAMPLE_0 = 6;

reg [2:0] state = IDLE;
reg [2:0] next_state;

always@(posedge clk) begin
	state <= next_state;
end

always@(*) begin
	case(state)
		IDLE			: if(sig_in == 0) next_state = OUTPUT_ZERO; else next_state = OUTPUT_ONE;
		// current : 0
		OUTPUT_ZERO     : if(sig_in == 0) next_state = OUTPUT_ZERO; else next_state = FIRST_SAMPLE_1;
		FIRST_SAMPLE_1  : if(sig_in == 0) next_state = OUTPUT_ZERO; else next_state = SECOND_SAMPLE_1;
		SECOND_SAMPLE_1 : if(sig_in == 0) next_state = OUTPUT_ZERO; else next_state = OUTPUT_ONE;
		// current : 1
		OUTPUT_ONE      : if(sig_in == 1) next_state = OUTPUT_ONE; else next_state = FIRST_SAMPLE_0;
		FIRST_SAMPLE_0  : if(sig_in == 1) next_state = OUTPUT_ONE; else next_state = SECOND_SAMPLE_0;
		SECOND_SAMPLE_0 : if(sig_in == 1) next_state = OUTPUT_ONE; else next_state = OUTPUT_ZERO;
	endcase
end 

always@(*) begin
	case(state)
		IDLE			:  if(sig_in == 0) sig_out = 1'b0; else sig_out = 1'b1;
		// current : 0
		OUTPUT_ZERO     : sig_out = 1'b0;
		FIRST_SAMPLE_1  : sig_out = 1'b0;
		SECOND_SAMPLE_1 : sig_out = 1'b0;
		// current : 1    
		OUTPUT_ONE      : sig_out = 1'b1;
		FIRST_SAMPLE_0  : sig_out = 1'b1;
		SECOND_SAMPLE_0 : sig_out = 1'b1;
	endcase
end

endmodule 