module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

// States
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

// Initialize state to A
always @(posedge clk or negedge resetn)
begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

// Assign next_state based on current state and inputs
always @*
begin
	case (state)
		A:
			if (~resetn)
				next_state = A;
			else if (x == 1'b1)
				next_state = B;
			else
				next_state = A;
		
		B:
			if (~resetn)
				next_state = A;
			else if (x == 1'b0)
				next_state = C;
			else
				next_state = A;
		
		C:
			if (~resetn)
				next_state = A;
			else if (x == 1'b1)
				next_state = D;
			else
				next_state = A;
		
		D:
			if (~resetn)
				next_state = A;
			else if (y == 1'b1)
				next_state = D;
			else
				next_state = A;
		
		default:
			next_state = A;
	endcase
end

// Outputs
always @(posedge clk or negedge resetn)
begin
	if (~resetn)
	begin
		f <= 1'b0;
		g <= 1'b0;
	end
	else
	begin
		case (state)
			A:
			begin
				f <= 1'b0;
				g <= 1'b0;
			end
			
			B:
			begin
				f <= 1'b1;
				g <= 1'b0;
			end
			
			C:
			begin
				f <= 1'b0;
				g <= 1'b0;
			end
			
			D:
			begin
				f <= 1'b0;
				g <= 1'b1;
			end
			
			default:
			begin
				f <= 1'b0;
				g <= 1'b0;
			end
		endcase
	end
end

endmodule
