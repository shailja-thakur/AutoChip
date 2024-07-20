module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		START,
		RECEIVING,
		STOP,
	} state_t;

	// Define signals
	logic [7:0] data;
	logic [2:0] state;
	logic start_bit;
	logic stop_bit;
	logic received;
	
	// Next-state and output logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data <= '0;
			done <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 0) begin
						start_bit <= 1;
						state <= START;
					end
				end
				START: begin
					if (in == 0) begin
						state <= RECEIVING;
					end else begin
						state <= IDLE;
					end
				end
				RECEIVING: begin
					data <= {data[6:0], in};
					state <= (data == 8'b10101010) ? STOP : RECEIVING;
				end
				STOP: begin
					if (in == 1) begin
						stop_bit <= 1;
						received <= 1;
						state <= IDLE;
					end
				end
				default: state <= IDLE;
			endcase
		end
	end

	// Done output
	assign done = received;

endmodule
