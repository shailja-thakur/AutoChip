module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	else begin
		state <= next_state;
	end
end

always @(state, w) begin
	case (state)
		A: begin
			if (s == 1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if ((w == 1'b1 && $past(w) == 1'b1) || (w == 1'b1 && $past($past(w)) == 1'b1) || (w == 1'b1 && $past($past($past(w))) == 1'b1)) begin
				z = 1;
			end else begin
				z = 0;
			end
			next_state = B;
		end
	endcase
end

endmodule
