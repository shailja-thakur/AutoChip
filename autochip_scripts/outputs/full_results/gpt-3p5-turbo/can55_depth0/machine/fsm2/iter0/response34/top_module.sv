module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	reg [1:0] state;
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // Reset to state A
		else
			state <= (state == 2'b01 && j) ? 2'b10 : (state == 2'b10 && k) ? 2'b01 : state;
	end
	
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
endmodule
