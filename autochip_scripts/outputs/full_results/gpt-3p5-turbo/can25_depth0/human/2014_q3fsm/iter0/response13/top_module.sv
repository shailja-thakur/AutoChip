module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state, w) begin
	next_state = state;

	case (state)
		A: begin
			if (s) begin
				next_state = B;
			end
		end
		B: begin
			if (w) begin
				next_state = A;
			end
		end
	endcase
end

always @(posedge clk) begin
	if (state == B) begin
		z <= ((w + $past(w) + $past($past(w))) == 2);
	end else begin
		z <= 0;
	end
end

endmodule
