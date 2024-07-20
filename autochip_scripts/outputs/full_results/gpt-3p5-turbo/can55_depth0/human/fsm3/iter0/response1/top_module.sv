module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
		out_reg <= 0;
	end else begin
		case (state)
			A: begin
				if (in) begin
					state <= B;
				end else begin
					state <= A;
				end
				out_reg <= 0;
			end
			
			B: begin
				if (in) begin
					state <= C;
				end else begin
					state <= B;
				end
				out_reg <= 0;
			end
			
			C: begin
				if (in) begin
					state <= D;
				end else begin
					state <= A;
				end
				out_reg <= 0;
			end
			
			D: begin
				if (in) begin
					state <= B;
				end else begin
					state <= C;
				end
				out_reg <= 1;
			end
		endcase
	end
end

assign out = out_reg;

endmodule
