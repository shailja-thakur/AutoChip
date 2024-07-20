module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] in_reg;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		in_reg <= 0;
		count <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					in_reg <= in;
					count <= 1;
				end
			end

			1: begin
				if (count == 2) begin
					if (in_reg[3] == 1) begin
						state <= 2;
						in_reg <= {in_reg[6:0], in};
						count <= 0;
					end else begin
						state <= 0;
						count <= 0;
					end
				end else begin
					state <= 1;
					in_reg <= {in_reg[6:0], in};
					count <= count + 1;
				end
			end

			2: begin
				if (count == 2) begin
					if (in_reg[3] == 1) begin
						state <= 3;
						in_reg <= {in_reg[6:0], in};
						count <= 0;
					end else begin
						state <= 0;
						count <= 0;
					end
				end else begin
					state <= 1;
					in_reg <= {in_reg[6:0], in};
					count <= count + 1;
				end
			end

			3: begin
				if (count == 2) begin
					if (in_reg[3] == 1) begin
						state <= 3;
						in_reg <= {in_reg[6:0], in};
						count <= 0;
						done <= 1;
					end else begin
						state <= 0;
						count <= 0;
						done <= 0;
					end
				end else begin
					state <= 1;
					in_reg <= {in_reg[6:0], in};
					count <= count + 1;
				end
			end
		endcase
	end
end

endmodule
