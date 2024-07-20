module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00; // A
	else if (state == 2'b00) begin
		if (in)
			state <= 2'b10; // B
	else if (state == 2'b10) begin
		if (in)
			state <= 2'b10; // B
		else
			state <= 2'b01; // C
	end else if (state == 2'b01) begin
		if (in)
			state <= 2'b11; // D
		else
			state <= 2'b00; // A
	end else begin // state == 2'b11
		if (in)
			state <= 2'b10; // B
		else
			state <= 2'b01; // C
	end
	
	if (state == 2'b11)
		out_reg <= 1'b1;
	else
		out_reg <= 1'b0;
end

assign out = out_reg;

endmodule
