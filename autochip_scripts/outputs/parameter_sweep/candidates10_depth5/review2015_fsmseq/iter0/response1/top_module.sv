module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	parameter IDLE = 2'b00;
	parameter S0   = 2'b01;
	parameter S1   = 2'b10;
	parameter FOUND = 2'b11;

	// Define signals
	reg [1:0] state;
	reg start_shifting;

	// Next-state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end 
		else begin
			case(state)
				IDLE: begin
					if (data) begin
						state <= S0;
					end
				end

				S0: begin
					if (data) begin
						state <= S1;
					end
					else begin
						state <= IDLE;
					end
				end

				S1: begin
					if (data) begin
						state <= FOUND;
						start_shifting <= 1;
					end
					else begin
						state <= IDLE;
					end
				end

				FOUND: begin
					state <= FOUND;
					start_shifting <= 1;
				end

				default: begin
					state <= IDLE;
					start_shifting <= 0;
				end
			endcase
		end
	end

endmodule
