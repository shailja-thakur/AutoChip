module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state, next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
	if(reset == 1'b1) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state, w) begin
	case(state)
		A: begin
			if(w == 1'b1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end

		B: begin
			if(w == 1'b1) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end

		C: begin
			if(w == 1'b1) begin
				next_state = E;
			end else begin
				next_state = D;
			end
		end

		D: begin
			if(w == 1'b1) begin
				next_state = F;
			end else begin
				next_state = A;
			end
		end

		E: begin
			if(state == E) begin
				if(w == 1'b1) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end else begin
				next_state = D;
			end
		end

		F: begin
			if(state == F) begin
				if(w == 1'b1) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end else begin
				next_state = A;
			end
		end

		default: next_state = A;
	endcase
end

always @(posedge clk) begin
	case(state)
		A: z <= 1'b0;
		E: z <= 1'b1;
		default: z <= 1'b0;
	endcase
end

endmodule
