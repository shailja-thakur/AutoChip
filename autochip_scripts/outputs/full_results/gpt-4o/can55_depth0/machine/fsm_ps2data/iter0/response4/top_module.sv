module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] shift_reg;

	localparam BYTE1 = 2'b00;
	localparam BYTE2 = 2'b01;
	localparam BYTE3 = 2'b10;
	localparam DONE = 2'b11;

	// State transition logic
	always @(*) begin
		case(state)
			BYTE1: begin
				if (in[2])
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				if (in[2])
					next_state = BYTE1;
				else
					next_state = BYTE1;
			end
			default: next_state = BYTE1;
		endcase
	end

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			case (state)
				BYTE1: begin
					shift_reg <= {shift_reg[15:0], in};
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
			endcase

			if (state != DONE) begin
				done <= 1'b0;
			end
		end
	end

endmodule
