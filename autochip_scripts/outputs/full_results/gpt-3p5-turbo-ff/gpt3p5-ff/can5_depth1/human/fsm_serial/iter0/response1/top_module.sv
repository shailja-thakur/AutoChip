module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg start_bit_detected;
reg [7:0] data_bits;
reg stop_bit_detected;

always @(posedge clk or posedge reset) begin : state_logic
	if (reset) begin
		state <= 0;
		start_bit_detected <= 0;
		data_bits <= 0;
		stop_bit_detected <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in == 1'b0) begin
					state <= 1; // Transition to start bit state
					start_bit_detected <= 1;
				end
			end
			1: begin // Start bit state
				state <= 2; // Transition to data bits state
				data_bits <= 0;
			end
			2: begin // Data bits state
				data_bits <= {data_bits[6:0], in}; // Shift in new bit
				state <= (state == 9) ? 3 : state + 1; // Transition to stop bit state after 8 data bits
			end
			3: begin // Stop bit state
				if (in == 1'b1) begin
					state <= 0; // Transition to idle state
					stop_bit_detected <= 1;
				end
			end
		endcase
	end
end

assign done = (state == 0) ? 1 : 0; // Output done signal when in idle state

endmodule
