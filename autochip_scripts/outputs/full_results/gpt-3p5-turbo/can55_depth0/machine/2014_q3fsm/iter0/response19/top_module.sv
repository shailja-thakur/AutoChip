module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(state or s or w) begin
    case (state)
        A: next_state = (s) ? B : state;
        B, C: next_state = (w) ? S11 : S10;
        S10: next_state = (w) ? S21 : S20;
        S11: next_state = (w) ? S22 : S21;
        S20: next_state = B;
        S21: next_state = (w) ? C : B;
        S22: next_state = (w) ? B : C;
        default: next_state = state;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset)
        z <= 0;
    else
        z <= (state == S20 || state == S22);
end

endmodule
