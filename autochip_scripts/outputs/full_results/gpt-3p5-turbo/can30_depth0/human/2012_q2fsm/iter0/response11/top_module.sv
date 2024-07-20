module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg[2:0] state_reg;
reg[2:0] state_next;

// state codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

always @(*) begin
	case (state_reg)
		A: begin
			if (w) begin
				state_next = B;
			end else begin
				state_next = A;
			end
		end

		B: begin
			if (w) begin
				state_next = C;
			end else begin
				state_next = D;
			end
		end

		C: begin
			if (w) begin
				state_next = E;
			end else begin
				state_next = D;
			end
		end

		D: begin
			if (w) begin
				state_next = F;
			end else begin
				state_next = A;
			end
		end

		E: begin
			if (w) begin
				state_next = E;
			end else begin
				state_next = D;
			end
		end

		F: begin
			if (w) begin
				state_next = C;
			end else begin
				state_next = D;
			end
		end

		default: begin
			state_next = A;
		end
	endcase
end

always @(state_reg) begin
	case (state_reg)
		A: begin
			z = 0;
		end

		B: begin
			z = 0;
		end

		C: begin
			z = 0;
		end

		D: begin
			z = 0;
		end

		E: begin
			z = 1;
		end

		F: begin
			z = 1;
		end

		default: begin
			z = 0;
		end
	endcase
end

endmodule
