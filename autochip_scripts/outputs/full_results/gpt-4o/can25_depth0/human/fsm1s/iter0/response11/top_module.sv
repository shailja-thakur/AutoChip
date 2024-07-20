module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= STATE_B;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_B: if (in) 
                        next_state = STATE_B;
                     else 
                        next_state = STATE_A;
            
            STATE_A: if (in)
                        next_state = STATE_A;
                     else 
                        next_state = STATE_B;
            
            default: next_state = STATE_B; // Default to reset state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default output for the reset state
        endcase
    end

endmodule
