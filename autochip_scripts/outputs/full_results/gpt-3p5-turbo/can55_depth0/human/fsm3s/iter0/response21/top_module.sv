module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge reset) 
begin
	if (reset)
		state <= 2'b00;
	else if (in)
	begin
		case (state)
			2'b00: state <= 2'b01;
			2'b01: state <= 2'b11;
			2'b10: state <= 2'b00;
			2'b11: state <= 2'b10;
		endcase
	end
	else
	begin
		case (state)
			2'b00: state <= 2'b00;
			2'b01: state <= 2'b01;
			2'b10: state <= 2'b10;
			2'b11: state <= 2'b11;
		endcase
	end
end

always @(state)
begin
	case (state)
		2'b00: out_reg = 1;
		2'b01: out_reg = 1;
		2'b10: out_reg = 0;
		2'b11: out_reg = 0;
	endcase
end

assign out = out_reg;

endmodule
