module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 0;
	else begin
		case(state)
			0: begin
				if (x)
					state <= 1;
				else
					state <= 0;
			end
			1: begin
				if (!x)
					state <= 2;
				else
					state <= 1;
			end
			2: begin
				state <= 2;
			end
		endcase
	end
end

always @(state, x) begin
	case(state)
		0: begin
			z <= x;
		end
		1: begin
			z <= ~x;
		end
		2: begin
			z <= ~x + 1;
		end
		default: begin
			z <= 0;
		end
	endcase
end

endmodule
