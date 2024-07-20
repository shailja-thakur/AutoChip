module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state, next_state;
	reg out_reg;

	// State assignments
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Reset state to A on reset signal
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state and output assignment
	always @(state or in) begin
		case(state)
			A: begin
				if (in) begin
					next_state <= B;
					out_reg <= 0;
				end else begin
					next_state <= A;
					out_reg <= 0;
				end
			end
			B: begin
				if (in) begin
					next_state <= B;
					out_reg <= 0;
				end else begin
					next_state <= C;
					out_reg <= 0;
				end
			end
			C: begin
				if (in) begin
					next_state <= D;
					out_reg <= 0;
				end else begin
					next_state <= A;
					out_reg <= 0;
				end
			end
			D: begin
				if (in) begin
					next_state <= B;
					out_reg <= 1;
				end else begin
					next_state <= C;
					out_reg <= 1;
				end
			end
		endcase
	end
	
	// Output assignment
	assign out = out_reg;
	
endmodule
