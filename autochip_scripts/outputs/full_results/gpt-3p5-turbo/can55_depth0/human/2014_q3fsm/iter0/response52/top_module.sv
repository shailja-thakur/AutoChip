module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state, w) begin
	case (state)
		A: begin
			if (s == 0) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
		
		B: begin
			if (w == 1) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
		
		C: begin
			if (w == 1) begin
				next_state = D;
				z <= 1;
			end else begin
				next_state = D;
				z <= 0;
			end
		end
		
		D: begin
			if (w == 1) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
	endcase
end

endmodule
