module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// State definition
reg [1:0] state;

// Output register
reg z;

// Next-state logic
always @(posedge clk or negedge areset) begin
	if (~areset) begin
		state <= 2'b00; // Reset state
	else begin
		case (state)
			2'b00: begin
				if (x == 1'b1)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
			2'b01: begin
				state <= 2'b10;
			end
			2'b10: begin
				if (x == 1'b0)
					state <= 2'b11;
				else
					state <= 2'b10;
			end
			2'b11: begin
				state <= 2'b10;
			end
		endcase
	end
end

// Output logic
always @(state, x) begin
	case (state)
		2'b00: begin
			z <= 1'b0;
		end
		2'b01: begin
			z <= 1'b1;
		end
		2'b10: begin
			z <= 1'b0;
		end
		2'b11: begin
			z <= ~x + 1'b1;
		end
	endcase
end

endmodule
