module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [3:0] state;
	reg [3:0] next_state;
	reg [3:0] count;

	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= S0;
			count <= 4'b0000;
		end else begin
			state <= next_state;
			count <= count + 1;
		end
	end

	always @(state or x) begin
		case (state)
			S0: begin
				if (x == 1) begin
					next_state = S1;
				end
			end
			S1: next_state = S0;
		endcase
	end

	always @(count) begin
		if (count == 3) begin
			z <= ~x + 1;
		end
	end

endmodule
