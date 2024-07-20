module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;
parameter C = 1'b0;
parameter S10 = 1'b0;
parameter S11 = 1'b0;
parameter S20 = 1'b0;
parameter S21 = 1'b0;
parameter S22 = 1'b0;

// Define the current and next state variables
reg [2:0] current_state;
reg [2:0] next_state;

// Register for z output
reg z_reg;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
	end else begin
		current_state <= next_state;
	end
end

// Output logic
always @(current_state) begin
	case (current_state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		S20: begin
			next_state = B;
		end
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
		default: begin
			next_state = A;
		end
	endcase
end

// Output assignment
always @(current_state) begin
	case (current_state)
		A: begin
			z_reg = 1'b0;
		end
		B: begin
			z_reg = 1'b0;
		end
		C: begin
			z_reg = 1'b0;
		end
		S10: begin
			z_reg = 1'b0;
		end
		S11: begin
			z_reg = 1'b0;
		end
		S20: begin
			z_reg = 1'b0;
		end
		S21: begin
			z_reg = 1'b0;
		end
		S22: begin
			z_reg = 1'b0;
		end
		default: begin
			z_reg = 1'b0;
		end
	endcase
end

// Assign stable value to output
always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 1'b0;
	end else begin
		z <= z_reg;
	end
end

endmodule
