module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State definitions
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b010;
parameter F = 2'b110;

// Flip-flop definitions
reg [1:0] current_state, next_state;

// State table
always @(posedge clk, negedge reset) begin
	if (reset) begin
		current_state <= A;
	end else begin
		current_state <= next_state;
	end
end

// Next state logic
always @* begin
	case (current_state)
		A: begin
			if (w) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if (w) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
		C: begin
			if (w) begin
				next_state = E;
			end else begin
				next_state = D;
			end
		end
		D: begin
			if (w) begin
				next_state = F;
			end else begin
				next_state = A;
			end
		end
		E: begin
			if (w) begin
				next_state = E;
			end else begin
				next_state = D;
			end
		end
		F: begin
			if (w) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
	endcase
end

// Output logic
always @* begin
	case (current_state)
		E: begin
			z = 1'b1;
		end
		default: begin
			z = 1'b0;
		end
	endcase
end

endmodule
