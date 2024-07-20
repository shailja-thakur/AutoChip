module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;  // Reset to state B
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B; // Default case; shouldn't occur
        endcase
    end
    
    // Output logic
    assign out = (state == STATE_B);

endmodule
