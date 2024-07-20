module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg start_shifting_sync;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
			start_shifting_sync <= 0;
		end else begin
			case (state)
				S0: begin
					if (data == 1) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end

				S1: begin
					if (data == 1) begin
						state <= S2;
					end else begin
						state <= S0;
					end
				end

				S2: begin
					if (data == 0) begin
						state <= S3;
					end else if (data == 1) begin
						state <= S2;
					end else begin
						state <= S0;
					end
				end

				S3: begin
					if (data == 1) begin
						state <= S1;
						start_shifting_sync <= 1;
					end else begin
						state <= S0;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			start_shifting <= 0;
		end else begin
			start_shifting <= start_shifting_sync;
		end
	end

endmodule
