module top_module (
	input  wire clk,
	input  wire areset,
	input  wire bump_left,
	input  wire bump_right,
	output wire walk_left,
	output wire walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state;
wire next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WL;
	end else begin
		state <= next_state;
	end
end

assign next_state = (state == WL && bump_left) ? WR :
                    (state == WR && bump_right) ? WL :
                    state;

assign walk_left  = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
