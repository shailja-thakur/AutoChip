module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] current_state;
	reg [1:0] next_state;
	reg out_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
			out_reg <= 1'b0;
		end else begin
			current_state <= next_state;
		end
	end
	
	always @(current_state, in) begin
		case (current_state)
			A: begin
				if (in) begin
					next_state <= B;
					out_reg <= 1'b0;
				end else begin
					next_state <= A;
					out_reg <= 1'b0;
				end
			end
			B: begin
				if (in) begin
					next_state <= B;
					out_reg <= 1'b0;
				end else begin
					next_state <= C;
					out_reg <= 1'b0;
				end
			end
			C: begin
				if (in) begin
					next_state <= D;
					out_reg <= 1'b0;
				end else begin
					next_state <= A;
					out_reg <= 1'b0;
				end
			end
			D: begin
				if (in) begin
					next_state <= B;
					out_reg <= 1'b1;
				end else begin
					next_state <= C;
					out_reg <= 1'b1;
				end
			end
			default: begin
				next_state <= A;
				out_reg <= 1'b0;
			end
		endcase
	end
	
	assign out = out_reg;
	
endmodule
