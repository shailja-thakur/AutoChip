module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare state variables
	reg [2:0] state;
	reg [2:0] next_state;

	// Declare output variables
	wire A_out, B_out, C_out, D_out, E_out, F_out;

	// Define state encodings
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	// Define combinational logic for next state and output generation
	always @* begin
		case (state)
			A: begin
				if (w)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			default: next_state = A;
		endcase

		case (state)
			A: begin
				A_out = 1'b0;
				B_out = 1'b1;
				C_out = 1'b0;
				D_out = 1'b0;
				E_out = 1'b0;
				F_out = 1'b0;
			end
			B: begin
				A_out = 1'b0;
				B_out = 1'b1;
				C_out = 1'b0;
				D_out = 1'b1;
				E_out = 1'b0;
				F_out = 1'b0;
			end
			C: begin
				A_out = 1'b0;
				B_out = 1'b1;
				C_out = 1'b0;
				D_out = 1'b1;
				E_out = 1'b0;
				F_out = 1'b0;
			end
			D: begin
				A_out = 1'b1;
				B_out = 1'b0;
				C_out = 1'b0;
				D_out = 1'b0;
				E_out = 1'b0;
				F_out = 1'b0;
			end
			E: begin
				A_out = 1'b0;
				B_out = 1'b0;
				C_out = 1'b0;
				D_out = 1'b1;
				E_out = 1'b1;
				F_out = 1'b0;
			end
			F: begin
				A_out = 1'b0;
				B_out = 1'b0;
				C_out = 1'b1;
				D_out = 1'b0;
				E_out = 1'b0;
				F_out = 1'b0;
			end
			default: begin
				A_out = 1'b0;
				B_out = 1'b0;
				C_out = 1'b0;
				D_out = 1'b0;
				E_out = 1'b0;
				F_out = 1'b0;
			end
		endcase
	end

	// Define sequential logic for state update
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Assign output
	assign z = A_out;

endmodule
