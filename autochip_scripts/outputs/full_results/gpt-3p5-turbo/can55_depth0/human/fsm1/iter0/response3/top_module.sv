module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define state types
typedef enum {
	B,
	A
} state_t;

// Declare state register
reg [1:0] state_reg;

// Declare output register
reg out_reg;

// Next State logic
always @(posedge clk or posedge areset) begin
	if (areset)
		state_reg <= B;
	else begin
		case (state_reg)
			B: begin
				if (in)
					state_reg <= B;
				else
					state_reg <= A;
			end
			A: begin
				if (in)
					state_reg <= A;
				else
					state_reg <= B;
			end
		endcase
	end
end

// Output logic
always @(state_reg) begin
	case (state_reg)
		B: out_reg = 1;
		A: out_reg = 0;
	endcase
end

// Assign output
assign out = out_reg;

endmodule
