module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
state_t state, next_state;

// State transition logic
always @(*) begin
    case (state)
        STATE_A: next_state = (in) ? STATE_A : STATE_B;
        STATE_B: next_state = (in) ? STATE_B : STATE_A;
        default: next_state = STATE_B; // Default to STATE_B
    endcase
end

// State flip-flops with asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) state <= STATE_B;
    else state <= next_state;
end

// Output logic
always @(*) begin
    out = (state == STATE_B);
end

endmodule
