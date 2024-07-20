module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin
					if (x) begin
						state <= 3'b001;
					end else begin
						state <= 3'b000;
					end
				end
				3'b001: begin
					if (x) begin
						state <= 3'b100;
					end else begin
						state <= 3'b001;
					end
				end
				3'b010: begin
					if (x) begin
						state <= 3'b001;
					end else begin
						state <= 3'b010;
					end
				end
				3'b011: begin
					if (x) begin
						state <= 3'b010;
					end else begin
						state <= 3'b011;
					end
				end
				3'b100: begin
					if (x) begin
						state <= 3'b101;
					end else begin
						state <= 3'b100;
					end
				end
				3'b101: begin
					if (x) begin
						state <= 3'b101;
					end else begin
						state <= 3'b110;
					end
				end
				3'b110: begin
					if (x) begin
						state <= 3'b101;
					end else begin
						state <= 3'b110;
					end
				end
				3'b111: begin
					if (x) begin
						state <= 3'b110;
					end else begin
						state <= 3'b111;
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (state)
			3'b100, 3'b101, 3'b110: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
