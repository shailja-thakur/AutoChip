module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        // Default next state
        next_state = current_state;
        case (current_state)
            STATE_A: if (w) next_state = STATE_A; else next_state = STATE_B;
            STATE_B: if (w) next_state = STATE_D; else next_state = STATE_C;
            STATE_C: if (w) next_state = STATE_D; else next_state = STATE_E;
            STATE_D: if (w) next_state = STATE_A; else next_state = STATE_F;
            STATE_E: if (w) next_state = STATE_D; else next_state = STATE_E;
            STATE_F: if (w) next_state = STATE_D; else next_state = STATE_C;
            default: next_state = STATE_A;
        endcase
    end
    
    // Output logic
    assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
