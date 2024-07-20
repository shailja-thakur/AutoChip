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
	localparam IDLE     = 2'b00;
	localparam BYTE_1   = 2'b01;
	localparam BYTE_2   = 2'b10;
	localparam BYTE_3   = 2'b11;

	// FSM state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// FSM next state logic
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in[3] == 1) next_state = BYTE_1;
			end
			BYTE_1: begin
				next_state = BYTE_2;
			end
			BYTE_2: begin
				next_state = BYTE_3;
			end
			BYTE_3: begin
				next_state = IDLE;
			end
		endcase
	end

	// Output and shift register logic
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			shift_reg <= 24'b0;
			done <= 0;
		end else begin
			done <= 0;
			case (state)
				BYTE_1: begin
					shift_reg[23:16] <= in;
				end
				BYTE_2: begin
					shift_reg[15:8] <= in;
				end
				BYTE_3: begin
					shift_reg[7:0] <= in;
					out_bytes <= {shift_reg[23:8], in};
					done <= 1;
				end
			endcase
		end
	end

endmodule
