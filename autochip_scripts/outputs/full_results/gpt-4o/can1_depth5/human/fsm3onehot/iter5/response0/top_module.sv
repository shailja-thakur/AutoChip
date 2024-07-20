module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out  // output should be reg since it's assigned in always block
);

    // State Encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

	// State Transition and Output Logic
	always @(*) begin
		case (state)
			A: begin
				next_state = in ? B : A;
				out = 1'b0;
			end
			B: begin
				next_state = in ? B : C;
				out = 1'b0;
			end
			C: begin
				next_state = in ? D : A;
				out = 1'b0;
			end
			D: begin
				next_state = in ? B : C;
				out = 1'b1;
			end
			default: begin
				next_state = A; // Initialize to a valid one-hot state A in case of invalid state input
				out = 1'b0;
			end
		endcase
	end

endmodule
