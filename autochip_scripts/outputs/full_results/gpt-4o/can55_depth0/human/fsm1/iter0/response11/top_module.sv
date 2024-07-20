module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t curr_state, next_state;

    // State transition logic on clock
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            curr_state <= STATE_B;
        end else begin
            curr_state <= next_state;
        end
    end

    // Next state logic based on current state and input
    always @(*) begin
        case (curr_state)
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
            default: next_state = STATE_B; // Reset State
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        case (curr_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to state B's output
        endcase
    end

endmodule
