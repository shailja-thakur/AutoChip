module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] current_state, next_state;

parameter A = 3'b000, B = 3'b001, C = 3'b010, S10 = 3'b011, S11 = 3'b100, S20 = 3'b101, S21 = 3'b110, S22 = 3'b111;

// State transition logic
always @(*) begin
    case (current_state)
        A: next_state = s ? B : current_state;
        B: next_state = w ? S11 : S10;
        C: next_state = w ? S11 : S10;
        S10: next_state = w ? S21 : S20;
        S11: next_state = w ? S22 : S21;
        S20: next_state = B;
        S21: next_state = w ? C : B;
        S22: next_state = w ? B : C;
        default: next_state = current_state;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

endmodule
