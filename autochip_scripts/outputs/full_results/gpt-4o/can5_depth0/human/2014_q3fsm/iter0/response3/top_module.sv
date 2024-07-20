module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// State encoding
typedef enum logic [1:0] {
	A = 2'b00,
	B = 2'b01,
	C = 2'b10
} state_t;

state_t state, next_state;
logic [1:0] count;

always_ff @(posedge clk) begin
	if (reset) begin
		state <= A;
		count <= 0;
	end else begin
		state <= next_state;
		if (state == B) begin
			if (count == 2'd3) begin
				count <= 0;
			end else begin
				count <= count + 1;
			end
		end
	end
end

always_comb begin
	next_state = state;
	z = 1'b0;
	case (state)
		A: begin
			if (s) begin
				next_state = B;
			end
		end
		B: begin
			if (count == 2'd3) begin
				next_state = C;
			end
		end
		C: begin
			if (w == 2'd2) begin
				z = 1'b1;
			end
			if (~s) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
	endcase
end

endmodule
