module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	// Define state wire
	reg [1:0] state;
	reg [1:0] next_state; // next state is saved in a register
	
	// Define output wire
	wire out;

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always_comb begin
		case (state)
			A: begin
				next_state = (in) ? B : A;
				out = 0;
			end
			B: begin
				next_state = (in) ? B : C;
				out = 0;
			end
			C: begin
				next_state = (in) ? D : A;
				out = 0;
			end
			D: begin
				next_state = (in) ? B : C;
				out = 1;
			end
		endcase
	end

endmodule
