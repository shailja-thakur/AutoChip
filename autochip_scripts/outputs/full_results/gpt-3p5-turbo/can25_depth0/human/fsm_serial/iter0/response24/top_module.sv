module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [3:0] state;
	reg prev_bit;
	reg receive_byte;
	reg [7:0] received_byte;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			prev_bit <= 1'b0;
			receive_byte <= 1'b0;
			received_byte <= 8'b0;
			done <= 1'b0;
		end else begin
			case (state)
				0: begin // Idle
					if (in == 1'b0 && prev_bit == 1'b1) begin
						state <= 4'b0001; // Start bit detected, transition to receiving
					end else begin
						state <= 4'b0000; // Stay in idle state
					end
				end
				1: begin // Receiving
					if (in == 1'b0 && prev_bit == 1'b0) begin
						state <= 4'b0010; // Received a data bit
						received_byte <= {in, received_byte[7:1]}; // Shift in the received bit
					end else if (in == 1'b0 && prev_bit == 1'b1) begin
						state <= 4'b0011; // Stop bit detected, transition to verifying stop bit
					end else begin
						state <= 4'b0000; // Restart if unexpected transition
					end
				end
				2: begin // Receiving
					if (in == 1'b0 && prev_bit == 1'b0) begin
						state <= 4'b0010; // Received a data bit
						received_byte <= {in, received_byte[7:1]}; // Shift in the received bit
					end else if (in == 1'b0 && prev_bit == 1'b1) begin
						state <= 4'b0011; // Stop bit detected, transition to verifying stop bit
					end else begin
						state <= 4'b0000; // Restart if unexpected transition
					end
				end
				3: begin // Verifying stop bit
					if (in == 1'b1 && prev_bit == 1'b0) begin
						state <= 4'b0100; // Valid stop bit detected, transition to done state
						receive_byte <= 1'b1; // Signal that a byte has been received
					end else if (in == 1'b0 && prev_bit == 1'b1) begin
						state <= 4'b0011; // Continue checking for stop bit
					end else begin
						state <= 4'b0000; // Restart if unexpected transition
					end
				end
				4: begin // Done state
					if (in == 1'b1 && prev_bit == 1'b1) begin
						state <= 4'b0000; // Transition back to idle state
						done <= 1'b1; // Signal that a byte has been processed
					end else begin
						state <= 4'b0000; // Restart if unexpected transition
					end
				end
			endcase
		end
		prev_bit <= in;
	end
	
endmodule
