module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		CHECK1 = 2'b10,
		CHECK2 = 2'b11
	} state_t;

	state_t state, next_state;
	reg [1:0] w_count;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			z <= 1'b0;
		end else begin
			state <= next_state;
			if (next_state == CHECK1) begin
				w_count <= 2'b00;
			end else if (state == B || state == CHECK1 || state == CHECK2) begin
				w_count <= w_count + w;
			end
			if (state == CHECK2) begin
				z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
			end
		end
	end

	always @(*) begin
		case (state)
			A:
				if (s) next_state = B;
				else next_state = A;
			B:
				next_state = CHECK1;
			CHECK1:
				next_state = CHECK2;
			CHECK2:
				next_state = B;
			default:
				next_state = A;
		endcase
	end

endmodule
