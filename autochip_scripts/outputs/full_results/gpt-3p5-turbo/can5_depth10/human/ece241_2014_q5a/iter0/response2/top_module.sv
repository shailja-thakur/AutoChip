module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 3'b000;
		z <= 1'b0;
	end else begin
		case (state)
			3'b000:
				if (x) begin
					state <= 3'b001;
				end else begin
					state <= 3'b000;
				end
			3'b001:
				if (x) begin
					state <= 3'b001;
				end else begin
					state <= 3'b010;
				end
			3'b010:
				if (x) begin
					state <= 3'b011;
				end else begin
					state <= 3'b010;
				end
			3'b011:
				if (x) begin
					state <= 3'b011;
				end else begin
					state <= 3'b100;
				end
			3'b100:
				if (x) begin
					state <= 3'b101;
				end else begin
					state <= 3'b100;
				end
			3'b101:
				if (x) begin
					state <= 3'b101;
				end else begin
					state <= 3'b110;
				end
			3'b110:
				if (x) begin
					state <= 3'b111;
				end else begin
					state <= 3'b110;
				end
			3'b111:
				if (x) begin
					state <= 3'b111;
				end else begin
					state <= 3'b000;
				end
			default:
				state <= 3'b000;
		endcase
	end
end

always @(state) begin
	case (state)
		3'b000:
			z <= 1'b0;
		3'b001:
			z <= 1'b1;
		3'b010:
			z <= 1'b0;
		3'b011:
			z <= 1'b1;
		3'b100:
			z <= 1'b0;
		3'b101:
			z <= 1'b1;
		3'b110:
			z <= 1'b0;
		3'b111:
			z <= 1'b1;
		default:
			z <= 1'b0;
	endcase
end

endmodule
