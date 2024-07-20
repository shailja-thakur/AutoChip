module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// define states
parameter A = 2'b00;
parameter B = 2'b01;

// define signals
reg [1:0] state, next_state;
reg z_reg;

always @(posedge clk, posedge areset)
begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @(*)
begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
			z_reg = 0;
		end
		B: begin
			if (x)
				next_state = B;
			else
				next_state = B;
			z_reg = 1;
		end
		default: begin
			next_state = A;
			z_reg = 0;
		end
	endcase
end

assign z = z_reg;

endmodule
