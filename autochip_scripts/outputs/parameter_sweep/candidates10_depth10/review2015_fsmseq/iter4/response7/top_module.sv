module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	reg [3:0] state;
	reg [1:0] match_count;

	always @(posedge clk) begin
		if (reset) begin
			state <= 4'b0000;
			match_count <= 2'b00;
		end else begin
			case (state)
				4'b0000: begin
					if (data) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0001: begin
					if (data) begin
						state <= 4'b0010;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0010: begin
					if (data) begin
						state <= 4'b0011;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0011: begin
					if (data) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
						if (match_count == 2'b10) begin
							start_shifting <= 1;
							match_count <= 2'b00;
						end else begin
							match_count <= match_count + 1;
						end
					end
				end
			endcase
		end
	end

endmodule
