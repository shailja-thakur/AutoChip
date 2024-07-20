module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State encoding
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;
	
	state_t current_state, next_state;
	reg [23:0] shift_register;

	// State transition logic
	always @(*) begin
		case (current_state)
			BYTE1: if (in[2] == 1) next_state = BYTE2; else next_state = BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE : if (in[2] == 1) next_state = BYTE1; else next_state = DONE;
			default: next_state = BYTE1;
		endcase
	end

	// Sequential logic for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
			shift_register <= 24'b0;
			done <= 0;
		end else begin
			current_state <= next_state;
			if (current_state == BYTE1 && in[2] == 1)
				shift_register <= {16'h0, in};
			else if (current_state == BYTE2)
				shift_register <= {shift_register[15:0], in};
			else if (current_state == BYTE3)
				shift_register <= {shift_register[15:0], in};
				
			if (current_state == DONE)
				done <= 1;
			else
				done <= 0;
		end
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
		end else if (done) begin
			out_bytes <= shift_register;
		end
	end

endmodule
