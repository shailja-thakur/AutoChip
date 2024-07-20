module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
reg z_reg;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @*
begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (x)
				next_state = B;
			else
				next_state = B;
		end
		default: begin
			next_state = A;
		end
	endcase
end

always @(posedge clk)
begin
	if (areset)
		z_reg <= 1'b0;
	else
		case (state)
			B: begin
				if (x)
					z_reg <= 1'b0;
				else
					z_reg <= 1'b1;
			end
			default: begin
				if (x)
					z_reg <= 1'b1;
				else
					z_reg <= 1'b0;
			end
		endcase
end

assign z = z_reg;

endmodule
