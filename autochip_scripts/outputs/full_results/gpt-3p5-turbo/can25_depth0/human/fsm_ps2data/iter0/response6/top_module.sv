module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg done;

	// State declaration
	reg [3:0] state, next_state;
	parameter STATE_IDLE = 0, STATE_WAIT_FIRST_BYTE = 1, STATE_WAIT_SECOND_BYTE = 2, STATE_WAIT_THIRD_BYTE = 3;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= STATE_IDLE;
		end else begin
			state <= next_state;
		end
	end

	// State next-state logic
	always @(*) begin
		next_state = state;
		done = 0;
		case (state)
			STATE_IDLE: begin
				if (in[3] && !reset) begin
					next_state = STATE_WAIT_FIRST_BYTE;
				end
			end
			STATE_WAIT_FIRST_BYTE: begin
				byte1 <= in;
				next_state = STATE_WAIT_SECOND_BYTE;
			end
			STATE_WAIT_SECOND_BYTE: begin
				byte2 <= in;
				next_state = STATE_WAIT_THIRD_BYTE;
			end
			STATE_WAIT_THIRD_BYTE: begin
				byte3 <= in;
				done = 1;
				next_state = STATE_IDLE;
			end
			default: next_state = STATE_IDLE;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 3'b0;
		end else begin
			if (done) begin
				out_bytes <= {byte1, byte2, byte3};
			end
		end
	end

endmodule
