module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 0;
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        0: if (in)
                next_state = 0;
           else
                next_state = 1;
        1: if (in)
                next_state = 1;
           else
                next_state = 0;
    endcase
end

assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
