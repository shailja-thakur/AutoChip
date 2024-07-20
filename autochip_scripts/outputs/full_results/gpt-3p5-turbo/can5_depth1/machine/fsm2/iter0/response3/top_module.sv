module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @(*) begin
	if (state == 2'b00) begin
		if (j == 1'b1) begin
			next_state = 2'b01;
		end
		else begin
			next_state = 2'b00;
		end
	end
	else begin
		if (k == 1'b1) begin
			next_state = 2'b00;
		end
		else begin
			next_state = 2'b01;
		end
	end
end

always @(posedge clk or posedge areset) begin
	if (areset == 1'b1) begin
		state <= 2'b00;
	end
	else begin
		state <= next_state;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
