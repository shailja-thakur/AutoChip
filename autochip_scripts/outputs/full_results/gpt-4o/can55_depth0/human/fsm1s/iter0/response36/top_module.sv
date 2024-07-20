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

    state_t current_state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (current_state)
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B;
        endcase
    end

    // State flip-flops with synchronous reset (sequential)
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic (Moore)
    always_ff @(posedge clk) begin
        case (current_state)
            STATE_B: out <= 1'b1;
            STATE_A: out <= 1'b0;
            default: out <= 1'b1;
        endcase
    end

endmodule
