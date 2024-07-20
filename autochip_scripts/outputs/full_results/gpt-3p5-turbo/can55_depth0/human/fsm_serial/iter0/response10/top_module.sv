module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;
	reg [7:0] received_byte;
	reg start_bit_detected;
	reg stop_bit_detected;

	// Initial state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			received_byte <= 8'b0;
			start_bit_detected <= 1'b0;
			stop_bit_detected <= 1'b0;
			done <= 1'b0;
		end else begin
			case(state)
				3'b000: begin // Idle state
					if (in == 1'b0) begin
						state <= 3'b001; // Go to Start bit detected state
						start_bit_detected <= 1'b1;
					end
				end
				3'b001: begin // Start bit detected state
					if (in == 1'b0) begin
						state <= 3'b010; // Go to Data receiving state
						received_byte <= 1'b0;
					end else begin
						state <= 3'b000; // Go back to Idle state
						start_bit_detected <= 1'b0;
					end
				end
				3'b010: begin // Data receiving state
					if (in == 1'b0) begin
						received_byte <= {received_byte[6:0], in}; // Shift in the received bit
					end else begin
						state <= 3'b011; // Go to Stop bit detected state
					end
				end
				3'b011: begin // Stop bit detected state
					if (in == 1'b1) begin
						state <= 3'b000; // Go back to Idle state
						stop_bit_detected <= 1'b1;
						done <= 1'b1;
					end else begin
						state <= 3'b100; // Go to Incomplete byte state
					end
				end
				3'b100: begin // Incomplete byte state
					if (in == 1'b0) begin
						state <= 3'b001; // Go to Start bit detected state
						start_bit_detected <= 1'b1;
					end
				end
			endcase
		end
	end
endmodule
