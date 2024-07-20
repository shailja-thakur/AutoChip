module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg state, next_state;

parameter S0 = 1'b0;
parameter S1 = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= S0;
    else
        state <= next_state;
end

always @(state, x) begin
    case (state)
        S0: begin
            next_state = S1;
            z = x;
        end

        S1: begin
            next_state = S1;
            z = ~x + 1;
        end
    endcase
end

endmodule
