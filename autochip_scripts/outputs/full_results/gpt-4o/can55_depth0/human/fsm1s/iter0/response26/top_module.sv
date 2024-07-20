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

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge reset) begin
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
                if (in == 0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end

            STATE_A: begin
                if (in == 0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    assign out = (state == STATE_B) ? 1'b1 : 1'b0;

endmodule
