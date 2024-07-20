module top_module (
	input wire clk,
	input wire in,
	input wire areset,
	output wire out
);

reg [1:0] state;
reg out_reg;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= B; // asynchronously reset to state B
	end else begin
		case (state)
			B: begin
				if (in) begin
					state <= B;
					out_reg <= 1'b1;
				end else begin
					state <= A;
					out_reg <= 1'b0;
				end
			end
			A: begin
				if (in) begin
					state <= A;
					out_reg <= 1'b0;
				end else begin
					state <= B;
					out_reg <= 1'b1;
				end
			end
		endcase
	end
end

assign out = out_reg;

endmodule
