module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	reg out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case (state)
				0: begin
					if (in) begin
						state <= 1;
					end else begin
						state <= 0;
					end
				end
				1: begin
					if (in) begin
						state <= 1;
					end else begin
						state <= 2;
					end
				end
				2: begin
					if (in) begin
						state <= 3;
					end else begin
						state <= 0;
					end
				end
				3: begin
					if (in) begin
						state <= 1;
					end else begin
						state <= 2;
					end
				end
			endcase
		end
	end

	always @(state) begin
		if (state == 3) begin
			out <= 1;
		end else begin
			out <= 0;
		end
	end

endmodule
