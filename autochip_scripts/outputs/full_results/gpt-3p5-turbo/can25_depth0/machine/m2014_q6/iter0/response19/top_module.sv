module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;
parameter C = 1'b0;
parameter D = 1'b1;
parameter E = 1'b0;
parameter F = 1'b1;

// Define the state variables
reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk) begin
	// State transition logic
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	// Next state logic
	case (state)
		A: begin
			if (w == 1'b0)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w == 1'b1)
				next_state = D;
			else
				next_state = C;
		end
		C: begin
			if (w == 1'b1)
				next_state = D;
			else
				next_state = E;
		end
		D: begin
			if (w == 1'b1)
				next_state = A;
			else
				next_state = F;
		end
		E: begin
			if (w == 1'b1)
				next_state = D;
			else
				next_state = E;
		end
		F: begin
			if (w == 1'b1)
				next_state = D;
			else
				next_state = C;
		end
	endcase
end

// Output assignment
always @*
	case (state)
		A: z = 1'b0;
		B: z = 1'b0;
		C: z = 1'b0;
		D: z = 1'b0;
		E: z = 1'b1;
		F: z = 1'b1;
	endcase
endmodule
