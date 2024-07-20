module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			case (state)
				4'b0000: begin // S
					if (data) begin
						state <= 4'b0001; // S1
					end else begin
						state <= 4'b0000; // S
					end
				end
				4'b0001: begin // S1
					if (data) begin
						state <= 4'b0011; // S11
					end else begin
						state <= 4'b0000; // S
					end
				end
				4'b0011: begin // S11
					if (data) begin
						// stay in S11
					end else begin
						state <= 4'b0110; // S110
					end
				end
				4'b0110: begin // S110
					if (data) begin
						state <= 4'b1111; // Done
					end else begin
						state <= 4'b0000; // S
					end
				end
				4'b1111: begin // Done
					state <= 4'b1111; // stay in Done
				end
			endcase
		end
	end

	assign start_shifting = (state == 4'b1111);

endmodule
