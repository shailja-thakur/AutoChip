module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Combinational block to determine the next state based on current state and inputs
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
            default: next_state = STATE_A;  // Default state
        endcase
    end

    // Clocked always block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;  // Reset to state A
        else
            current_state <= next_state;  // Update to next state
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;  // Reset out to 0
        else
            out <= (current_state == STATE_B) ? 1'b1 : 1'b0;
    end

endmodule
