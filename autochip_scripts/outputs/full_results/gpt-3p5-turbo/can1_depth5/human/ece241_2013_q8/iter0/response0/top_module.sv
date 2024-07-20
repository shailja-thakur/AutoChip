module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= S0;
	end else begin
		case(state)
			S0: begin
				if (x == 1'b1)
					state <= S1;
				else
					state <= S0;
				z <= 1'b0;
			end
			S1: begin
				if (x == 1'b0)
					state <= S2;
				else
					state <= S1;
				z <= 1'b0;
			end
			S2: begin
				if (x == 1'b1) begin
					state <= S1;
					z <= 1'b1;
				end else if (x == 1'b0) begin
					state <= S0;
					z <= 1'b0;
				end
			end
			default: state <= S0;
		endcase
	end
end

endmodule
