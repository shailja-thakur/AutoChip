module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	// Define states
	parameter IDLE = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (data) begin
						state <= S1;
						start_shifting <= 0;
					end
				end
				S1: begin
					if (data) begin
						state <= S2;
						start_shifting <= 0;
					end else begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
				S2: begin
					if (data) begin
						state <= S3;
						start_shifting <= 0;
					end else begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
				S3: begin
					if (data) begin
						state <= S4;
						start_shifting <= 0;
					end else begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
				S4: begin
					if (data) begin
						state <= S1;
						start_shifting <= 1;
					end else begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
			endcase
		end
	end
endmodule
