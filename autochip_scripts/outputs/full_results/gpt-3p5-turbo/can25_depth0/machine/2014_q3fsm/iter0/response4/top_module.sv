module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// State enumeration
typedef enum logic [3:0] {
    A, B, C, S10, S11, S20, S21, S22
} state_type;

// State signals
reg [3:0] current_state;
reg [3:0] next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// State transition conditions
always @(current_state, s, w) begin
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

// Output and next state assignment logic
always @(current_state) begin
    case (current_state)
        A: z = 0;
        B, C, S10, S11, S20, S21, S22: z = 1;
    endcase
end

endmodule
