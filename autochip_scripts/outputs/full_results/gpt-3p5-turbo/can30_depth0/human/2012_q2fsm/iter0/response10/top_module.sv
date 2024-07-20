module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define the states
parameter A = 2'd0;
parameter B = 2'd1;
parameter C = 2'd2;
parameter D = 2'd3;
parameter E = 2'd4;
parameter F = 2'd5;

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
	case (state)
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

// FSM output
always @(state) begin
	case (state)
		E: begin
			z = 1'b1;
		end
		
		default: begin
			z = 1'b0;
		end
	endcase
end

endmodule
