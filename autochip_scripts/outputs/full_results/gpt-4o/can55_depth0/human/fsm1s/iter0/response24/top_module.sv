module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // On reset, go to state B
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // Output logic based on state
    assign out = (current_state == STATE_B) ? 1'b1 : 1'b0;

endmodule
