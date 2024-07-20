module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State Transition
    always @(*) begin
        case (state)
            STATE_A: if (in) next_state = STATE_A;
                     else next_state = STATE_B;
            STATE_B: if (in) next_state = STATE_B;
                     else next_state = STATE_A;
            default: next_state = STATE_B; // Default to STATE_B on unexpected condition
        endcase
    end
    
    // State Flip-Flops with Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end
    
    // Output Logic
    always @(state) begin
        case (state)
            STATE_A: out = 0;
            STATE_B: out = 1;
            default: out = 1;
        endcase
    end

endmodule
