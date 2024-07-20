module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_B = 2'b01,
        STATE_A = 2'b10
    } state_t;

    // Current state and next state variables
    reg state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;  // Reset state
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
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B;  // Default to avoid latch inference
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1'b0;
        endcase
    end

endmodule
