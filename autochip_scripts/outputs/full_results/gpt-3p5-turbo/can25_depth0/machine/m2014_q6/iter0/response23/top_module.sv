module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin
					if (w == 1'b0)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin
					if (w == 1'b1)
						state <= 3'b011;
					else
						state <= 3'b010;
				end
				3'b010: begin
					if (w == 1'b0)
						state <= 3'b011;
					else
						state <= 3'b100;
				end
				3'b011: begin
					if (w == 1'b1)
						state <= 3'b000;
					else
						state <= 3'b110;
				end
				3'b100: begin
					if (w == 1'b0)
						state <= 3'b011;
					else
						state <= 3'b100;
				end
				3'b110: begin
					if (w == 1'b1)
						state <= 3'b011;
					else
						state <= 3'b110;
				end
				default: state <= 3'b000;
			endcase
		end
	end

	always @(state, w) begin
		case (state)
			3'b100, 3'b110: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
