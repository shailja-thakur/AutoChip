module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	typedef enum reg [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
	state_t state, next_state;
	reg [23:0] out_reg;

	// State transition logic
	always @(*) begin
		case (state)
			BYTE1: if (in[2] == 1'b1) next_state = BYTE2; else next_state = BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = (in[2] == 1'b0) ? BYTE1 : DONE;
			default: next_state = BYTE1;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			case (state)
				BYTE1: begin
					out_reg <= {out_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE2: begin
					out_reg <= {out_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE3: begin
					out_reg <= {out_reg[15:0], in};
					done <= 1'b0;
				end
				DONE: begin
					out_bytes <= out_reg;
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
