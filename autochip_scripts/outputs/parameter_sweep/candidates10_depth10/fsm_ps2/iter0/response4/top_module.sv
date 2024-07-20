module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define states
	typedef enum logic [1:0] {
		IDLE,
		WAIT_BYTE1,
		WAIT_BYTE2,
		WAIT_BYTE3,
		DONE
	} state_type;

	// Define signals
	logic [1:0] state;
	logic [7:0] byte1;
	logic [7:0] byte2;
	logic [7:0] byte3;

	// Define FSM
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in[3] == 1) begin
						byte1 <= in;
						state <= WAIT_BYTE2;
					end
				end
				WAIT_BYTE2: begin
					byte2 <= in;
					state <= WAIT_BYTE3;
				end
				WAIT_BYTE3: begin
					byte3 <= in;
					state <= DONE;
				end
				DONE: begin
					if (in[3] == 1) begin
						byte1 <= in;
						state <= WAIT_BYTE2;
					end else begin
						state <= IDLE;
						done <= 1;
					end
				end
			endcase
		end
	end
endmodule
