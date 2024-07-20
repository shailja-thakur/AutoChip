module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case(state)
				0: begin
					if (data) begin
						state <= 1;
					end else begin
						state <= 0;
					end
				end
				1: begin
					if (data) begin
						state <= 2;
					end else begin
						state <= 0;
					end
				end
				2: begin
					if (data) begin
						state <= 3;
					end else begin
						state <= 0;
					end
				end
				3: begin
					if (data) begin
						start_shifting <= 1;
						state <= 0;
					end else begin
						state <= 0;
					end
				end
			endcase
		end
	end

endmodule
