module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Declare state encoding
    typedef enum logic [1:0] {
        STATE_A = 2'd0,
        STATE_B = 2'd1,
        STATE_C = 2'd2,
        STATE_D = 2'd3
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = in ? STATE_B : STATE_A;
            STATE_B: next_state = in ? STATE_B : STATE_C;
            STATE_C: next_state = in ? STATE_D : STATE_A;
            STATE_D: next_state = in ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Default state for safety
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0; // Default output for safety
        endcase
    end
    
endmodule
