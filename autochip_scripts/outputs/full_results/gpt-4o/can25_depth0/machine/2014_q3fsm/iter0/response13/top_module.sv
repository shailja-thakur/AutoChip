module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// State declaration
typedef enum reg [3:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_S10,
    STATE_S11,
    STATE_S20,
    STATE_S21,
    STATE_S22
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition
always @(posedge clk or posedge reset) begin
    if (reset) 
        current_state <= STATE_A;
    else 
        current_state <= next_state;
end

// Combinational logic for next state
always @(*) begin
    case (current_state)
        STATE_A: 
            if (s) 
                next_state = STATE_B;
            else 
                next_state = STATE_A;
        STATE_B: 
            if (w) 
                next_state = STATE_S11;
            else 
                next_state = STATE_S10;
        STATE_C: 
            if (w) 
                next_state = STATE_S11;
            else 
                next_state = STATE_S10;
        STATE_S10: 
            if (w) 
                next_state = STATE_S21;
            else 
                next_state = STATE_S20;
        STATE_S11: 
            if (w) 
                next_state = STATE_S22;
            else 
                next_state = STATE_S21;
        STATE_S20: 
            next_state = STATE_B;
        STATE_S21: 
            if (w) 
                next_state = STATE_C;
            else 
                next_state = STATE_B;
        STATE_S22: 
            if (w) 
                next_state = STATE_B;
            else 
                next_state = STATE_C;
        default: 
            next_state = STATE_A;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_S10,
        STATE_S20: z = 0;
        STATE_S11,
        STATE_S21,
        STATE_S22: z = 1;
        default: z = 0;
    endcase
end

endmodule
