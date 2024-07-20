module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

	reg [1:0] state; // Define state as a 2-bit register

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= 2'b0; // Set state to A when reset is high
		end else begin
			if (state == 2'b0 && j == 1'b1) begin
				state <= 2'b1; // Transition from state A to B when j is high
			end else if (state == 2'b1 && k == 1'b1) begin
				state <= 2'b0; // Transition from state B to A when k is high
			end
		end
	end

	assign out = (state == 2'b1) ? 1'b1 : 1'b0; // Set output to high when state is B, and low when state is A

endmodule
