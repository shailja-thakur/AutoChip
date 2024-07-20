module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define state encoding
    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    // Register to hold the current state
    state_t current_state, next_state;

    // Combinational always block to determine the next state
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

    // Clocked always block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    assign out = (current_state == STATE_B);

endmodule
