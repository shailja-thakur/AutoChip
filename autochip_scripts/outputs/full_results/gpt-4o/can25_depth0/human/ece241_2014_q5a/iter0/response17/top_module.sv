module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	reg state, next_state;
	reg inverting;
	reg first_one;

	// State encoding
	localparam S0 = 1'b0; // Waiting for first zero after the reset release
	localparam S1 = 1'b1; // After the first one is seen, start inverting the bits

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			inverting <= 0;
			first_one <= 1;
		end
		else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			S0: begin
				if (x & first_one) begin
					next_state = S1;
					inverting = 1;
					first_one = 0;
				end
				else begin
					next_state = S0;
					inverting = first_one ? 0 : 1;
					first_one = first_one;
				end
			end
			S1: begin
				next_state = S1;
				inverting = 1;
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
		end
		else begin
			if (inverting) begin
				z <= ~x;
			else begin
				z <= x;
			end
		end
	end

endmodule
