module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b01,
        STATE_A = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_B: begin
                if (in) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Default/reset state
        endcase
    end

    // State flip-flops with synchronous reset (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic (Moore)
    always @(*) begin
        case (state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1; // Default output for undefined state
        endcase
    end

endmodule
