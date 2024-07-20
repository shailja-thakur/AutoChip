module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
wire y1, y2;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
			z = 0;
		end
		
		B: begin
			if (x)
				next_state = B;
			else
				next_state = B;
			z = ~x;
		end
	endcase
end

endmodule
