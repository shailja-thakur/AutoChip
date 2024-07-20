module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare the state variable
	reg [2:0] state;

	// Declare the next state variable
	reg [2:0] next_state;

	// Declare the output variable
	wire z_out;

	// Define the state encoding
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	localparam E = 3'b100;
	localparam F = 3'b101;

	// Define the next state logic
	always @ (state, w) begin
		case (state)
			A: begin
				if (w == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (w == 1'b0)
					next_state = C;
				else
					next_state = D;
			end
			C: begin
				if (w == 1'b0)
					next_state = E;
				else
					next_state = D;
			end
			D: begin
				if (w == 1'b0)
					next_state = F;
				else
					next_state = A;
			end
			E: begin
				if (w == 1'b0)
					next_state = E;
				else
					next_state = D;
			end
			F: begin
				if (w == 1'b0)
					next_state = C;
				else
					next_state = F;
			end
			default: next_state = A;
		endcase
	end

	// Define the sequential logic
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Define the output logic
	assign z_out = (state == E || state == F);

	// Assign the output
	assign z = z_out;

endmodule
