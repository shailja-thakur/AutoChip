module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declaration
    typedef enum reg {
        STATE_A, 
        STATE_B
    } state_t;
    
    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j == 1'b1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k == 1'b1)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: 
                next_state = STATE_A;
        endcase
    end

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else if (state == STATE_B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
