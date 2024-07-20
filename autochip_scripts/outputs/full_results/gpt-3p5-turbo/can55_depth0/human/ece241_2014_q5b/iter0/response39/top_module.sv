module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, state_next;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= state_next;
end

always @(state or x) begin
	case (state)
		2'b00: begin
			if (x)
				state_next = 2'b10;
			else
				state_next = 2'b00;
			z = 1'b0;
		end
		2'b01: begin
			if (x)
				state_next = 2'b01;
			else
				state_next = 2'b01;
			z = 1'b1;
		end
		2'b10: begin
			if (x)
				state_next = 2'b10;
			else
				state_next = 2'b01;
			z = 1'b1;
		end
		default: begin
			state_next = 2'b01;
			z = 1'b0;
		end
	endcase
end

endmodule
