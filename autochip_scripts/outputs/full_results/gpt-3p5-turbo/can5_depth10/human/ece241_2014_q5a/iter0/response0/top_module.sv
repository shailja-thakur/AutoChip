module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state <= 2'b00;
	else begin
		state <= next_state;
	end
end

always @(state or x) begin
	case (state)
		2'b00: begin
			next_state <= 2'b01;
			z <= 1'b0;
		end
		2'b01: begin
			next_state <= 2'b10;
			z <= ~x;
		end
		2'b10: begin
			next_state <= 2'b10;
			z <= ~x;
		end
	endcase
end

endmodule
