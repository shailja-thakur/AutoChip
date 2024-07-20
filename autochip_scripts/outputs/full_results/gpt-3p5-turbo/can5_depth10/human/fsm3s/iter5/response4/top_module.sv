module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	reg [1:0] state, next_state;
    
	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= A;
		else
			state <= next_state;
	end
    
	always @(state, in) begin
		case(state)
			A: begin
				if(in)
					next_state <= B;
				else
					next_state <= C; // Corrected state transition
				out <= 1'b0;
			end
			B: begin
				if(in)
					next_state <= D; // Corrected state transition
				else
					next_state <= B;
				out <= 1'b0;
			end
			C: begin
				if(in)
					next_state <= A;
				else
					next_state <= D; // Corrected state transition
				out <= 1'b0;
			end
			D: begin
				if(in)
					next_state <= B; // Corrected state transition
				else
					next_state <= C;
				out <= 1'b1;
			end
			default: begin
				next_state <= A;
				out <= 1'b0;
			end
		endcase
	end

endmodule
