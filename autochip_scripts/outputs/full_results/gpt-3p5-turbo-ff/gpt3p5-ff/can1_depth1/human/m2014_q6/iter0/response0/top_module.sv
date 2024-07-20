module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state or w) begin
	case (state)
		A: begin
			if (w) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
		B: begin
			if (w) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
		C: begin
			if (w) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		D: begin
			if (w) begin
				next_state = A;
			end else begin
				next_state = F;
			end
		end
		E: begin
			if (w) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		F: begin
			if (w) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
		default: next_state = A;
	endcase
end

always @(state) begin
	case (state)
		A: z = 0;
		B: z = 0;
		C: z = 0;
		D: z = 0;
		E: z = 1;
		F: z = 1;
		default: z = 0;
	endcase
end

endmodule
