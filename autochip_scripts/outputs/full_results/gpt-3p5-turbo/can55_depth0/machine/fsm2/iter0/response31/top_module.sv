module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg state, next_state;

always @* begin
	if(state == 1'b0) begin
		if(j == 1'b1) 
			next_state = 1'b1;
		else 
			next_state = 1'b0;
	end
	else begin
		if(k == 1'b1)
			next_state = 1'b0;
		else 
			next_state = 1'b1;
	end
end

always @(posedge clk) begin
	if(areset == 1'b1)
		state <= 1'b0;
	else
		state <= next_state;
end

assign out = state; 

endmodule
