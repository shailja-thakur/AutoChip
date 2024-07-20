module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Internal state variables
	reg [3:0] state;

	// State definitions
	localparam IDLE = 4'b0000;
	localparam S1 = 4'b0001;
	localparam S2 = 4'b0010;
	localparam S3 = 4'b0100;
	localparam FOUND = 4'b1000;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (data) begin
						state <= S1;
					end
				end

				S1: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S2;
					end
				end

				S2: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S3;
					end
				end

				S3: begin
					if (!data) begin
						state <= IDLE;
					end else begin
						state <= FOUND;
						start_shifting <= 1;
					end
				end

				FOUND: begin
					if (reset) begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
			endcase
		end
	end

endmodule
