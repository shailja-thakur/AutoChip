module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Current and next state
    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output
    always_comb begin
        next_state = current_state; // Default assignment
        case (current_state)
            STATE_A: begin
                out = 0;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                out = 0;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            STATE_C: begin
                out = 0;
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                out = 1;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
        endcase
    end
endmodule
