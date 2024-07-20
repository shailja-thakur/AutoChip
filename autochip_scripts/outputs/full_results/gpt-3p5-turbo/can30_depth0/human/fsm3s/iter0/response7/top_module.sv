module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

// Define the state variable
reg [1:0] state;
reg [1:0] next_state;

// Define the output variable
reg out;

// Synchronous reset
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		out <= 1'b0;
	end else begin
		state <= next_state;
		out <= (state == D) ? 1'b1 : 1'b0;
	end
end

// Define the next state and output logic
always @(state, in) begin
	case(state)
		A: begin
			if(in)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if(in)
				next_state = B;
			else
				next_state = C;
		end
		C: begin
			if(in)
				next_state = D;
			else
				next_state = A;
		end
		D: begin
			if(in)
				next_state = B;
			else
				next_state = C;
		end
		default: next_state = A;
	endcase
end

endmodule
