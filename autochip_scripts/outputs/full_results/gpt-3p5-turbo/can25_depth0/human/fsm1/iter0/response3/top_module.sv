module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= B;
	else
	begin
		case (state)
			B: if (in == 1'b0)
					state <= A;
				else
					state <= B;
			A: if (in == 1'b0)
					state <= B;
				else
					state <= A;
			default: state <= B;
		endcase
	end
end

always @(posedge clk)
begin
	case (state)
		B: out_reg <= 1'b0;
		A: out_reg <= 1'b1;
		default: out_reg <= 1'b0;
	endcase
end

assign out = out_reg;

endmodule
