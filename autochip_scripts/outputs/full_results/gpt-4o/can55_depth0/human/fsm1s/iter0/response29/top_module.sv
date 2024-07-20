module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_B: begin
                if (in == 1'b0) next_state = STATE_A;
                else next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0) next_state = STATE_B;
                else next_state = STATE_A;
            end
            default: next_state = STATE_B; // Default to State B
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default to output of State B
        endcase
    end

endmodule
