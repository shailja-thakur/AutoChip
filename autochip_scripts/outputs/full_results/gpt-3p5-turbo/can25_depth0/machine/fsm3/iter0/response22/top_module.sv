module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// 2-bit state register
reg [1:0] state; 

// Output logic
assign out = (state == 2'b11) ? 1'b1 : 1'b0;

// Combinational logic for next state determination
always @ (posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00;
	else
	begin
		case (state)
			2'b00: state <= (in) ? 2'b01 : 2'b00;
			2'b01: state <= (in) ? 2'b01 : 2'b10;
			2'b10: state <= (in) ? 2'b11 : 2'b00;
			2'b11: state <= (in) ? 2'b01 : 2'b10;
		endcase
	end
end

endmodule
