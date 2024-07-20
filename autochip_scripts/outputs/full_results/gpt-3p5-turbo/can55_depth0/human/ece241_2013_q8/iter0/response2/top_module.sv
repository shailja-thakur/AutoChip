module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;

parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;

always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= S0; // Initial state
		z <= 0; // Reset output signal
	end else begin
		case (state)
			S0: begin
				if (x == 1'b1)
					state <= S1;
				else
					state <= S0;
			end
			S1: begin
				if (x == 1'b0)
					state <= S0;
				else
					state <= S2;
			end
			S2: begin
				if (x == 1'b1) begin
					state <= S1;
					z <= 1; // Assert output signal when "101" sequence is detected
				end else
					state <= S0;
			end
		endcase
	end
end

endmodule
