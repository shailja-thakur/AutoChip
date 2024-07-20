module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset to state B
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b1; // Output for state B
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 1'b0; // Output for state A
            end
            default: begin
                next_state = STATE_B; // Default to state B
                out = 1'b1; // Output for state B
            end
        endcase
    end

endmodule
