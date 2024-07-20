module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @* begin
	if (state == 2'b00) begin
		next_state = j ? 2'b01 : 2'b00;
	end else if (state == 2'b01) begin
		next_state = k ? 2'b00 : 2'b01;
	end
end

always @(posedge clk) begin
	if (areset) begin
		state <= 2'b00;
	end else begin
		state <= next_state;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
