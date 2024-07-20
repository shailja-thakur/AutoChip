module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define signals
reg [1:0] state;
reg [1:0] next_state;

// State flip-flop
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// State table
always @(state or w) begin
	case(state)
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
		default: next_state = 2'b00; // Default to state A if none of the cases match
	endcase
end

// Assign output z
always @(state) begin
	case (state)
		E: z = 1'b1;
		default: z = 1'b0; // Output z is 0 for all other states
	endcase
end

endmodule
