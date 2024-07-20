module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State definition
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;
    
    state_t state, next_state;
    
    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end
    
    // Output logic
    always_comb begin
        out = (state == STATE_B) ? 1'b1 : 1'b0;
    end
    
endmodule
