module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter A = 2'b00, B = 2'b01;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else if (state == A) begin
			if (j) begin
				state <= B;
			end else begin
				state <= A;
			end
		end else begin // state == B
			if (k) begin
				state <= A;
			end else begin
				state <= B;
			end
		end
	end
	
	always @(state) begin
		if (state == B) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end
endmodule
