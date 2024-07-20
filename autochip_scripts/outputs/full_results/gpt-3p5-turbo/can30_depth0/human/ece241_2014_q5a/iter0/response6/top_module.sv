module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;
reg [2:0] z_reg;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S0;
		z_reg <= 3'b000;
	end
	else begin
		state <= next_state;
		z_reg <= z_next;
	end
end

always @(state, x) begin
	case(state)
		S0: begin
			if (x == 1'b0)
				next_state = S1;
			else
				next_state = S0;
			z_next = z_reg;
		end
		S1: begin
			if (x == 1'b0)
				next_state = S2;
			else
				next_state = S3;
			z_next = ~z_reg;
		end
		S2: begin
			if (x == 1'b0)
				next_state = S4;
			else
				next_state = S3;
			z_next = ~z_reg;
		end
		S3: begin
			next_state = S3;
			z_next = ~z_reg;
		end
		S4: begin
			if (x == 1'b0)
				next_state = S4;
			else
				next_state = S5;
			z_next = z_reg;
		end
		S5: begin
			if (x == 1'b0)
				next_state = S5;
			else
				next_state = S5;
			z_next = z_reg;
		end
	endcase
end

assign z = z_reg;

endmodule
