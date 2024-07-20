module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Encoding
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;
	
	state_t current_state, next_state;
	
	// Register to hold shift register value
	reg [23:0] shift_reg;

	// Next state logic
	always @(*) begin
		case (current_state)
			BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE : next_state = BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			current_state <= next_state;
			case (current_state)
				BYTE1: begin
					if (in[2] == 1'b1) begin
						shift_reg <= {shift_reg[15:0], in};
					end
				end
				BYTE2: shift_reg <= {shift_reg[15:0], in};
				BYTE3: shift_reg <= {shift_reg[15:0], in};
				DONE: begin
					out_bytes <= shift_reg;
					done <= 1'b1;
				end
			endcase
		end
	end

	// Reset done signal when not in DONE state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 1'b0;
		end else if (current_state != DONE) begin
			done <= 1'b0;
		end
	end

endmodule
