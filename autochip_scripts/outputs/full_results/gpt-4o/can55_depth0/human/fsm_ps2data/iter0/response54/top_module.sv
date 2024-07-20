module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] byte_shift_reg;

	localparam IDLE = 2'b00,
	           BYTE1 = 2'b01,
	           BYTE2 = 2'b10,
	           BYTE3 = 2'b11;

	// State Transition Logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	// Next State Logic
	always @(*) begin
		case (state)
			IDLE:   if (in[3]) next_state = BYTE1; else next_state = IDLE;
			BYTE1:  next_state = BYTE2;
			BYTE2:  next_state = BYTE3;
			BYTE3:  next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end
	
	// Output Logic
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'd0;
			done <= 1'b0;
			byte_shift_reg <= 24'd0;
		end else begin
			done <= 1'b0;
			case (state)
				IDLE: begin
					byte_shift_reg <= 24'd0;
				end
				BYTE1: begin
					byte_shift_reg <= {byte_shift_reg[15:0], in};
				end
				BYTE2: begin
					byte_shift_reg <= {byte_shift_reg[15:0], in};
				end
				BYTE3: begin
					byte_shift_reg <= {byte_shift_reg[15:0], in};
					out_bytes <= {byte_shift_reg[15:0], in};
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
