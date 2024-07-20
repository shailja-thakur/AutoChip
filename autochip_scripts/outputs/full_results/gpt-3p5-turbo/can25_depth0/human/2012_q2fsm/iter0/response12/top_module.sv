module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define the states using parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

reg [2:0] current_state;
reg [2:0] next_state;

// State register
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
	end
	else begin
		current_state <= next_state;
	end
end

// State transitions
always @(*) begin
	case (current_state)
		A:
			if (w) begin
				next_state = B;
			end
			else begin
				next_state = A;
			end
		B:
			if (w) begin
				next_state = C;
			end
			else begin
				next_state = D;
			end
		C:
			if (w) begin
				next_state = E;
			end
			else begin
				next_state = D;
			end
		D:
			if (w) begin
				next_state = F;
			end
			else begin
				next_state = A;
			end
		E:
			if (w) begin
				next_state = E;
			end
			else begin
				next_state = D;
			end
		F:
			if (w) begin
				next_state = C;
			end
			else begin
				next_state = D;
			end
		default:
			next_state = A;
	endcase
end

// Output assignment
always @(current_state) begin
	case (current_state)
		E, F:
			z = 1'b1;
		default:
			z = 1'b0;
	endcase
end

endmodule
