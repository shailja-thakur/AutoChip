module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Declare states
parameter A = 4'b0001;
parameter B = 4'b0010;
parameter C = 4'b0100;
parameter D = 4'b1000;
parameter E = 4'b0101;
parameter F = 4'b1100;

// Declare state register
reg [3:0] state_reg;
reg [3:0] state_next;

// Declare output register
reg output_reg;
reg output_next;

// Assign initial state
always @(posedge clk or posedge reset) begin
	if (reset)
		state_reg <= A;
	else
		state_reg <= state_next;
end

// Assign next state and output based on current state and inputs
always @(state_reg or w) begin
	case (state_reg)
		A: begin
			if (w)
				state_next = A;
			else
				state_next = B;
			output_next = 0;
		end
		B: begin
			if (w)
				state_next = D;
			else
				state_next = C;
			output_next = 0;
		end
		C: begin
			if (w)
				state_next = D;
			else
				state_next = E;
			output_next = 0;
		end
		D: begin
			if (w)
				state_next = A;
			else
				state_next = F;
			output_next = 0;
		end
		E: begin
			if (w)
				state_next = D;
			else
				state_next = E;
			output_next = 1;
		end
		F: begin
			if (w)
				state_next = D;
			else
				state_next = C;
			output_next = 1;
		end
	endcase
end

// Assign state and output registers
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
		output_reg <= 0;
	end else begin
		state_reg <= state_next;
		output_reg <= output_next;
	end
end

// Assign output
assign z = output_reg;

endmodule
