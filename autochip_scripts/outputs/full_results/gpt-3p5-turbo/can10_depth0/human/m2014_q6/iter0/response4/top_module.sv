module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000:
					if (w) begin
						state <= 3'b000;
					end else begin
						state <= 3'b001;
					end
				3'b001:
					if (w) begin
						state <= 3'b000;
					end else begin
						state <= 3'b001;
					end
				3'b010:
					if (w) begin
						state <= 3'b011;
					end else begin
						state <= 3'b010;
					end
				3'b011:
					if (w) begin
						state <= 3'b100;
					end else begin
						state <= 3'b011;
					end
				3'b100:
					if (w) begin
						state <= 3'b101;
					end else begin
						state <= 3'b110;
					end
				3'b101:
					if (w) begin
						state <= 3'b101;
					end else begin
						state <= 3'b011;
					end
				3'b110:
					if (w) begin
						state <= 3'b001;
					end else begin
						state <= 3'b110;
					end
				default:
					state <= 3'b000;
			endcase
		end
	end

	always @(*) begin
		case (state)
			3'b000: z = 1'b0;
			3'b001: z = 1'b0;
			3'b010: z = 1'b0;
			3'b011: z = 1'b1;
			3'b100: z = 1'b0;
			3'b101: z = 1'b0;
			3'b110: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
