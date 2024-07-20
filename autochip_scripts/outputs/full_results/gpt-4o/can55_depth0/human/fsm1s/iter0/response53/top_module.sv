module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_B; // Reset state is B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            default: begin
                next_state = STATE_B; // Should never reach here
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 1'b1; // Output for state B
        end else begin
            case (state)
                STATE_A: out <= 1'b0; // Output for state A
                STATE_B: out <= 1'b1; // Output for state B
                default: out <= 1'b1; // Output for undefined state (fallback)
            endcase
        end
    end

endmodule
