module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state = 2'b00;

always @(posedge clk) begin
	if(reset)
		state <= 2'b00;
	else if(state == 2'b00) begin
		if(j)
			state <= 2'b01;
		else
			state <= 2'b00;
	end
	else if(state == 2'b01) begin
		if(k)
			state <= 2'b00;
		else
			state <= 2'b01;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
