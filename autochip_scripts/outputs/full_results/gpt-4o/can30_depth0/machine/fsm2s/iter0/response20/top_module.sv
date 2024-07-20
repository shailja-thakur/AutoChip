module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {
        STATE_A = 2'd0,
        STATE_B = 2'd1
    } state_t;
    
    // Current and next state variables
    state_t current_state, next_state;

    // State transition logic - next state determination
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(current_state) begin
        out = (current_state == STATE_B);
    end

endmodule
