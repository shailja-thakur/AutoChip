module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

parameter A = 0;
parameter B = 1;

always @(posedge clk) begin
	if (areset) begin
		state <= B;
	end else begin
		state <= next_state;
	end
end

always @* begin
	if (state == A) begin
		if (in) begin
			next_state = A;
		end else begin
			next_state = B;
		end
	end else if (state == B) begin
		if (in) begin
			next_state = B;
		end else begin
			next_state = A;
		end
	end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
