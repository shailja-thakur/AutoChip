module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// state A: If s is asserted, next state is B
// state B: If w is asserted, next state is S11, otherwise next state is S10
// state C: If w is asserted, next state is S11, otherwise next state is S10
// state S10: If w is asserted, next state is S21, otherwise next state is S20
// state S11: If w is asserted, next state is S22, otherwise next state is S21
// state S20: next state is B
// state S21: If w is asserted, next state is C, otherwise next state is B
// state S22: If w is asserted, next state is B, otherwise next state is C

reg [3:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0;
    else begin
        case (state)
            0: if (s) state <= 1;
            1: if (w) state <= 3; else state <= 2;
            2: if (w) state <= 3; else state <= 4;
            3: if (w) state <= 5; else state <= 3;
            4: if (w) state <= 1; else state <= 5;
            5: if (w) state <= 2; else state <= 1;
        endcase
    end
end

always @(state) begin
    case (state)
        0: z <= 0;
        1: z <= 0;
        2: z <= 0;
        3: z <= 0;
        4: z <= 0;
        5: z <= 1;
    endcase
end

endmodule
