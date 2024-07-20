module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] shift_reg;

	// State encoding
	localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 0;
		end else begin
			state <= next_state;

			case (state)
				BYTE1: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 0;
				end
				BYTE2: shift_reg <= {shift_reg[15:0], in};
				BYTE3: shift_reg <= {shift_reg[15:0], in};
				DONE: begin
					out_bytes <= shift_reg;
					done <= 1;
				end
			endcase
		end
	end

	always @(*) begin
		case (state)
			BYTE1: 
				if (in[2] == 1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: 
				if (in[2] == 0)
					next_state = BYTE1;
				else
					next_state = DONE;
			default: next_state = BYTE1;
		endcase
	end
endmodule
