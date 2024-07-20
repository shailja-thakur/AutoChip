module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;

	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			S0: begin
				if (~areset)
					next_state = S1;
			end
			S1: begin
				if (~areset)
					next_state = S2;
			end
			S2: begin
				if (~areset)
					next_state = S0;
			end
		endcase
	end

	always @(state) begin
		case (state)
			S0: begin
				z = x;
			end
			S1: begin
				z = ~x + 1;
			end
			S2: begin
				z = ~x;
			end
		endcase
	end

endmodule
