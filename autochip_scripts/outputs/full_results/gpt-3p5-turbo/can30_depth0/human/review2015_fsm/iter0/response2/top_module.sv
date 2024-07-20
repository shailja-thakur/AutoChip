module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	// Define the states of the finite-state machine
	typedef enum logic [2:0] {
		SEARCH,
		CONFIRM,
		WAIT_COUNTING,
		NOTIFY,
		WAIT_ACK
	} state_t;

	reg state; // Current state of the state machine

	always @(posedge clk) begin
		if (reset) begin
			state <= SEARCH; // Reset to the initial state
		end else begin
			case (state)
				SEARCH: begin
					if (data == 4'b1101) begin
						shift_ena <= 1;
						state <= CONFIRM;
					end
				end

				CONFIRM: begin
					shift_ena <= 0;
					counting <= 1;
					state <= WAIT_COUNTING;
				end

				WAIT_COUNTING: begin
					if (done_counting) begin
						done <= 1;
						state <= NOTIFY;
					end
				end

				NOTIFY: begin
					if (ack) begin
						done <= 0;
						state <= WAIT_ACK;
					end
				end

				WAIT_ACK: begin
					if (ack) begin
						state <= SEARCH;
					end
				end
			endcase
		end
	end

endmodule
