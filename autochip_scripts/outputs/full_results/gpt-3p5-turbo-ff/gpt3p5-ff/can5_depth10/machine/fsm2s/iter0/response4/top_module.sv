module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state; // state variable to hold the current state

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'd0; // initialize state to A
		end else begin
			if (state == 2'd0) begin // if state is A
				if (j) begin
					state <= 2'd1; // next state is B if j is high
				end
			end else begin // if state is B
				if (k) begin
					state <= 2'd0; // next state is A if k is high
				end
			end
		end
	end

	assign out = (state == 2'd1) ? 1'b1 : 1'b0; // output is high if state is B, low if state is A

endmodule
