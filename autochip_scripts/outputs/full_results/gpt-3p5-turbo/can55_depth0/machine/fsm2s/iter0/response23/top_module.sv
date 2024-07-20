module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// State definition
	reg [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;

	// Output assignment
	assign out = (state == B) ? 1'b1 : 1'b0;
	
	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else if (state == A) begin
			if (j) begin
				state <= B;
			end
		end else if (state == B) begin
			if (k) begin
				state <= A;
			end
		end
	end

endmodule
