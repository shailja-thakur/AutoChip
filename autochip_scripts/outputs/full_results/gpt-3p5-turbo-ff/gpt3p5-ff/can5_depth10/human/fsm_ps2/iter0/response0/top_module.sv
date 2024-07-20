module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	typedef enum logic [1:0] {
		IDLE,
		BYTE_1,
		BYTE_2,
		BYTE_3
	} state_t;

	// Declare signals
	reg state_t current_state;
	reg [2:0] byte_count;

	// Define state transitions and next state logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else begin
			case (current_state)
				IDLE: begin
					if (in[3] == 1) begin
						current_state <= BYTE_1;
						byte_count <= 1;
					end
				end
				BYTE_1: begin
					if (byte_count == 2)
						current_state <= BYTE_2;
					else if (in[3] == 0) begin
						current_state <= IDLE;
						byte_count <= 0;
					end else
						byte_count <= byte_count + 1;
				end
				BYTE_2: begin
					if (byte_count == 2)
						current_state <= BYTE_3;
					else if (in[3] == 0) begin
						current_state <= IDLE;
						byte_count <= 0;
					end else
						byte_count <= byte_count + 1;
				end
				BYTE_3: begin
					if (in[3] == 0) begin
						current_state <= IDLE;
						byte_count <= 0;
					end else begin
						current_state <= IDLE;
						byte_count <= 0;
						done <= 1;
					end
				end
			endcase
		end
	end

	// Initialize signals
	always_comb done = 0;

endmodule
