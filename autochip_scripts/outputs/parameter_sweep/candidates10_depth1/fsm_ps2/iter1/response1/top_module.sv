module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);
reg [1:0] state;
reg [7:0] in_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					in_reg <= in;
				end
			end
			1: begin
				if (in[3] == 1) begin
					state <= 2;
				end else begin
					state <= 0;
				end
			end
			2: begin
				if (in[3] == 1) begin
					state <= 3;
				end else begin
					state <= 0;
				end
			end
			3: begin
				state <= 0;
				done <= 1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		in_reg <= 0;
	end else begin
		in_reg <= in;
	end
end

endmodule
