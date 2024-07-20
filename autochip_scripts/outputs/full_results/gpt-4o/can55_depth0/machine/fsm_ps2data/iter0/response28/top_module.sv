module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State encoding
	localparam BYTE1 = 2'b00;
	localparam BYTE2 = 2'b01;
	localparam BYTE3 = 2'b10;
	localparam DONE  = 2'b11;

	reg [1:0] state, next_state;
	reg [23:0] shift_reg;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
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
				next_state = BYTE1;
			end
			default: begin
				next_state = BYTE1;
			end
		endcase
	end

	// Output logic and shift register management
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			case (state)
				BYTE1: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE2: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				BYTE3: begin
					shift_reg <= {shift_reg[15:0], in};
					done <= 1'b0;
				end
				DONE: begin
					out_bytes <= shift_reg;
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
