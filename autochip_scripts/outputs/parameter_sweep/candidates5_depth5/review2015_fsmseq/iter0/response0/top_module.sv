module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting); // Added reg keyword to declare start_shifting as a register

	reg [3:0] state; // Added state register to keep track of the current state

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			start_shifting <= 0; // Reset the start_shifting signal
			state <= 0; // Reset the state variable
		end else begin
			case (state) // Use a case statement to implement the finite-state machine
				4'b0000: begin // Initial state
					if (data == 1) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end

				4'b0001: begin
					if (data == 1) begin
						state <= 4'b0011;
					end else begin
						state <= 4'b0000;
					end
				end

				4'b0011: begin
					if (data == 0) begin
						state <= 4'b0110;
					end else begin
						state <= 4'b0000;
					end
				end

				4'b0110: begin
					if (data == 1) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end

				default: state <= 4'b0000;
			endcase

			if (state == 4'b0110) begin
				start_shifting <= 1; // Set start_shifting to 1 when the sequence 1101 is found
			end else begin
				start_shifting <= 0;
			end
		end
	end
endmodule
