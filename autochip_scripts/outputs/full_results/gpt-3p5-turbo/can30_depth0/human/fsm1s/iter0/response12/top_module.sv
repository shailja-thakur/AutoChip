module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter B = 1'b0;
	parameter A = 1'b1;
	reg [1:0] state;

	// Define output
	assign out = (state == A) ? 1'b0 : 1'b1;

	// Define state transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
		end else begin
			if (state == B) begin
				if (in == 1'b0) begin
					state <= A;
				end else begin
					state <= B;
				end
			end else if (state == A) begin
				if (in == 1'b0) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
		end
	end
endmodule
