module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

reg [1:0] state, next_state;

// State flip-flop
always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// State table
always @(*) begin
	case (state)
		A: begin
			if (w)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = C;
			else
				next_state = D;
		end
		C: begin
			if (w)
				next_state = E;
			else
				next_state = D;
		end
		D: begin
			if (w)
				next_state = F;
			else
				next_state = A;
		end
		E: begin
			if (z)
				next_state = E;
			else
				next_state = D;
		end
		F: begin
			if (z)
				next_state = C;
			else
				next_state = D;
		end
		default: next_state = A;
	endcase
end

// FSM output
always @(state) begin
	case (state)
		E, F: begin
			z = 1'b1;
		end
		default: begin
			z = 1'b0;
		end
	endcase
end

endmodule
