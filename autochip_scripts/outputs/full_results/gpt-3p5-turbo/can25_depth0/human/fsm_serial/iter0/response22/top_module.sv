module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Register to hold the current state of the FSM
	reg [2:0] state;

	// Parameter for defining the duration of each clock cycle
	parameter CLK_PERIOD = 10;

	// Counter to keep track of the number of bits received
	reg [2:0] bit_counter;

	// Flip-flop to store the received bits
	reg [7:0] received_byte;

	// Output to indicate that a byte has been correctly received
	wire byte_received;

	// Assign statement to determine if a byte has been correctly received
	assign byte_received = (received_byte[7:0] == 8'hAA);

	// Always block to provide synchronous behavior
	always @(posedge clk) begin

		// Check for reset signal
		if (reset) begin
			state <= 3'b000;	// Idle state
			bit_counter <= 3'b000;
			received_byte <= 8'b0;
		end 
		else begin
			case (state)
				3'b000: begin	// Idle state
					if (in == 1'b0) begin
						state <= 3'b001;	// Start bit detected
						received_byte <= 8'b0;
						bit_counter <= 3'b000;
					end else begin
						state <= 3'b000;	// Stay in idle state
					end
				end
				3'b001: begin	// Receiving data bits
					received_byte <= {received_byte[6:0], in};
					bit_counter <= bit_counter + 3'b001;

					if (bit_counter == 3'b100) begin
						state <= 3'b010;	// All data bits received
					end else begin
						state <= 3'b001;	// Continue receiving data bits
					end
				end
				3'b010: begin	// Receiving stop bit
					if (in == 1'b1) begin
						state <= 3'b011;	// Stop bit detected
					end else begin
						state <= 3'b010;	// Continue receiving stop bit
					end
				end
				3'b011: begin	// Byte received
					if (byte_received) begin
						state <= 3'b000;	// Go back to idle state
					end else begin
						state <= 3'b011;	// Stay in byte received state
					end
				end
			endcase
		end

	end

	// Assign statement to indicate if a byte has been correctly received
	assign done = (state == 3'b011);

endmodule
