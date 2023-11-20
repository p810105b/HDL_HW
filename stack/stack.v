module stack(clk, data_in, cmd, data_out, full, empty, error, sp); 

input 	    clk; 
input [7:0] data_in;  	   /* input data for push operations, sampled at posedge clk */
input [1:0] cmd;      	   /* 00: no operation, 01: clear, 10: push, 00: pop, sampled at the positive edges of the clock */ 

output reg [7:0] data_out; /* retrieved data for pop operations, changes at posedge clk */ 
output reg       full;     /* flag set when the stack is full, updated at negedge clk */ 
output reg       empty;    /* flag set when the stack is empty, updated at negedge clk */ 
output reg       error;    /* flag set when push is asserted if stack is full or when pop is asserted if stack is empty */ 

reg  [7:0] RAM [0:7];      /* 8 X 8 memory module to hold stack data, changes at posedge clk */ 
reg  [2:0] sp;             /* 3-bit wide stack pointer, updated at negative edges of the clock */ 
wire [7:0] dout;           /* dout is always equal to RAM[sp] */ 

reg [2:0] next_sp;
reg next_empty, next_error, next_full;

parameter NO_OP	= 0;
parameter CLEAR = 1;
parameter PUSH  = 2;
parameter POP	= 3;

assign dout = RAM[sp];

// data in & out
integer i;
always@(posedge clk) begin
	/*
	if(reset) begin
		for(i=0; i<8; i=i+1) begin
			RAM[sp] <= 8'd0;
		end
	end
	else */
	if(cmd == PUSH && (full == 1'b0)) begin
		RAM[sp] <= data_in;
	end
end

always@(posedge clk) begin
	data_out <= dout;
end


// FSM
always@(negedge clk) begin
	sp 	  <= next_sp;
	full  <= next_full;
	error <= next_error;
	empty <= next_empty;
end

// next flag logic
always@(*) begin
	case(cmd)
		CLEAR : begin
			next_sp    = 3'b000;
			next_full  = 1'b0;
			next_error = 1'b0;
			next_empty = 1'b1;
		end
		PUSH  : begin
			if(full == 1'b1) begin
				next_sp    = 3'b000;
				next_full  = 1'b1;
				next_empty = 1'b0;
				next_error = 1'b1;
			end
			else if(empty == 1'b1) begin
				next_sp    = 3'b001;
				next_full  = 1'b0;
				next_empty = 1'b0;
				next_error = 1'b0;
			end
			else if(sp <= 3'b110) begin
				next_sp    = sp + 3'd1;
				next_full  = 1'b0;
				next_empty = 1'b0;
				next_error = 1'b0;
			end
			else if(sp == 3'b111) begin
				next_sp    = sp + 3'd1;
				next_full  = 1'b1;
				next_empty = 1'b0;
				next_error = 1'b0;
			end	
		end
		POP	  : begin
			if(full == 1'b1) begin
				next_sp    = 3'b111;
				next_full  = 1'b0;
				next_empty = 1'b0;
				next_error = 1'b0;
			end	
			else if(empty == 1'b1) begin
				next_sp    = 3'b000;
				next_full  = 1'b0;
				next_empty = 1'b1;
				next_error = 1'b1;
			end
			else if(sp >= 3'b001) begin
				next_sp    = sp - 3'd1;
				next_full  = 1'b0;
				next_empty = 1'b0;
				next_error = 1'b0;
			end
			else if(sp == 3'b000) begin
				next_sp    = sp - 3'd1;
				next_full  = 1'b0;
				next_empty = 1'b1;
				next_error = 1'b0;
			end	
		end
	endcase
end

endmodule
