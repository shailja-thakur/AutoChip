module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010;

always @(posedge clk or negedge aresetn) begin
	if (aresetn == 1'b0)
		state <= S0;
	else begin
		case (state)
			S0: if (x == 1'b1)
					state <= S1;
				else
					state <= S0;
			S1: if (x == 1'b0)
					state <= S2;
				else if (x == 1'b1)
					state <= S1;
				else
					state <= S0;
			S2: if (x == 1'b1)
					state <= S1;
				else if (x == 1'b0)
					state <= S2;
				else
					state <= S0;
		endcase
	end
end

always @(posedge clk or negedge aresetn) begin
	if (aresetn == 1'b0)
		z <= 1'b0;
	else if (state == S2)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
