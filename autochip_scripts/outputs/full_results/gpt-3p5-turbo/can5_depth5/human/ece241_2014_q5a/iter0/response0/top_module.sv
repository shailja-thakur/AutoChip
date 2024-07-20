module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [2:0] state;
reg [2:0] next_state;
reg z;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= 0;
		z <= 0;
	end else begin
		state <= next_state;
		z <= x;
	end
end

always @(state) begin
	case (state)
		0: begin
			z = x;
			next_state = 1;
		end
		1: begin
			z = ~x + 1;
			next_state = 2;
		end
		2: begin
			z = ~x;
			next_state = 1;
		end
		default: z = 0;
	endcase
end

endmodule
