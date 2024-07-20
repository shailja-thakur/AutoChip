module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
 
parameter A = 1'b0;
parameter B = 1'b1;
 
reg state;
 
always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end else begin
		if (state == A) begin
			state <= in ? A : B;
		end else begin
			state <= in ? B : A;
		end
	end
end
 
assign out = state;
 
endmodule
