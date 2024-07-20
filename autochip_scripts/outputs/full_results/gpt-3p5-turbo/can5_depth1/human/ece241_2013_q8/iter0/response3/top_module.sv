module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state;
reg prev;
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= S0;
		prev <= 0;
	end
	else begin
		case(state)
			S0: begin
				if (x == 1'b1 && prev == 1'b0)
					state <= S1;
				else
					state <= S0;
			end
			S1: begin
				if (x == 1'b0 && prev == 1'b1)
					state <= S2;
				else
					state <= S0;
			end
			S2: begin
				if (x == 1'b1 && prev == 1'b0) begin
					state <= S1;
					z <= 1'b1;
				end
				else begin
					state <= S1;
					z <= 1'b0;
				end
			end
		endcase
		prev <= x;
	end
end

endmodule
