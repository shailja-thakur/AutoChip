module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare the states as binary constants
	parameter [1:0] A = 2'b00;
	parameter [1:0] B = 2'b01;
	parameter [1:0] C = 2'b10;
	parameter [1:0] D = 2'b11;

	reg [1:0] current_state;
	reg [1:0] next_state;
	reg [1:0] output_reg;

	// Define the state transition and output logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
			output_reg <= 0;
		end
		else begin
			current_state <= next_state;
			output_reg <= (current_state == D) ? 1 : 0;
		end
	end

	// Define the state transition and output logic
	always @* begin
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end

	// Assign the output from output_reg
	assign out = output_reg;

endmodule
