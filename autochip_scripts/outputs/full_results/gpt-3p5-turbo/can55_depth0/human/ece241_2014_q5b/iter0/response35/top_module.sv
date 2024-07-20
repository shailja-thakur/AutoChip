module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg next_state;

always @(posedge clk) begin
	if (areset) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

always @(state or x) begin
	next_state = 2'b00;
	z = 1'b0;
	
	case (state)
		2'b00: begin
			next_state = x ? 2'b01 : 2'b00;
			z = x;
		end
		2'b01: begin
			next_state = x ? 2'b00 : 2'b01;
			z = ~x;
		end
	endcase
end

endmodule
