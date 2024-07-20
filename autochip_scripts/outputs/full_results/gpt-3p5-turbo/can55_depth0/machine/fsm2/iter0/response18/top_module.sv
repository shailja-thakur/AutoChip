module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

always_comb begin
    case(state)
        A: next_state = (j) ? B : A;
        B: next_state = (k) ? A : B;
    endcase
end

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
