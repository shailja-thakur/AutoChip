module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;
parameter A = 5'b00001, B = 5'b00010, C = 5'b00100, S10 = 5'b01000, S11 = 5'b10000, S20 = 5'b00101, S21 = 5'b00110, S22 = 5'b00111;

// State transition logic
always @(*) begin
    case (state)
        A: next_state = s ? B : state;
        B: next_state = w ? S11 : S10;
        C: next_state = w ? S11 : S10;
        S10: next_state = w ? S21 : S20;
        S11: next_state = w ? S22 : S21;
        S20: next_state = B;
        S21: next_state = w ? C : B;
        S22: next_state = w ? B : C;
        default: next_state = state;
    endcase
end

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
