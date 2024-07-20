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

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_B; // synchronous reset to state B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            default: begin
                next_state = STATE_B; // Default state is B
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 1'b1; // state B output
        end else begin
            case (state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
                default: out <= 1'b1; // Should not happen
            endcase
        end
    end

endmodule
