module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, S10 = 4'b0011, S11 = 4'b0100, S20 = 4'b0101, S21 = 4'b0110, S22 = 4'b0111;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: next_state = (s) ? B : state;
        B: next_state = (w) ? S11 : S10;
        C: next_state = (w) ? S11 : S10;
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
        case (state)
            S20, S21, S22: z <= 1;
            default: z <= 0;
        endcase
end

endmodule
