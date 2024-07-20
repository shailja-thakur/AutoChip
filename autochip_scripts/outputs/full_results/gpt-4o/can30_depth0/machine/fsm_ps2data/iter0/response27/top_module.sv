module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Declaration
	typedef enum reg [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] shift_reg;

	// State Transition Logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end

	// Next State Logic
	always @(*) begin
		case (state)
			BYTE1: next_state = (in[3] == 1'b1) ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// Output Logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
			shift_reg <= 24'b0;
			done <= 1'b0;
		end else begin
			case (state)
				BYTE1: begin
					if (in[3] == 1'b1) begin
						shift_reg <= {shift_reg[15:0], in};
					end
				end
				BYTE2: begin
					shift_reg <= {shift_reg[15:0], in};
				end
				BYTE3: begin
					shift_reg <= {shift_reg[15:0], in};
				end
				DONE: begin
					out_bytes <= shift_reg;
					done <= 1'b1;
				end
				default: begin
					out_bytes <= 24'b0;
					done <= 1'b0;
				end
			endcase
		end
	end

endmodule
