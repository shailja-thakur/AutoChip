module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
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
            default: next_state = STATE_B;
        endcase
    end

    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
