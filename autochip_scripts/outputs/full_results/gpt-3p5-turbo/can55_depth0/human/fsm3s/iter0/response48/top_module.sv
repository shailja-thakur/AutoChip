module top_module (
	input wire clk,
	input wire in,
	input wire reset,
	output wire out
);

reg [1:0] state;
reg out_reg;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk) begin
	if(reset) begin
		state <= A;
		out_reg <= 0;
	end else begin
		case (state)
			A: begin
				if(in)
					state <= B;
				else
					state <= A;
				out_reg <= 0;
			end
			B: begin
				if(in)
					state <= C;
				else
					state <= B;
				out_reg <= 0;
			end
			C: begin
				if(in)
					state <= A;
				else
					state <= D;
				out_reg <= 0;
			end
			D: begin
				if(in)
					state <= C;
				else
					state <= B;
				out_reg <= 1;
			end
			default: begin
				state <= A;
				out_reg <= 0;
			end
		endcase
	end
end

assign out = out_reg;

endmodule
