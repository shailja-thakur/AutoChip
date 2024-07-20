module top_module (
	input wire clk,
	input wire in,
	input wire areset,
	output wire out
);

reg [1:0] state;
always @(posedge clk or posedge areset)
begin
	if (areset) 
		state <= 2'b00; // reset to state A
	else
	begin
		case (state)
			2'b00: state <= (in) ? 2'b01 : 2'b00; // A -> B or stay in A
			2'b01: state <= (in) ? 2'b01 : 2'b10; // B -> B or C
			2'b10: state <= (in) ? 2'b11 : 2'b00; // C -> D or A
			2'b11: state <= (in) ? 2'b01 : 2'b10; // D -> B or C
		endcase
	end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
