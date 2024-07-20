module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                    out = 0;
                end else begin
                    next_state = STATE_B;
                    out = 0;
                end
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                    out = 1;
                end else begin
                    next_state = STATE_A;
                    out = 1;
                end
            end
            default: begin
                next_state = STATE_B;
                out = 1;
            end
        endcase
    end

endmodule
