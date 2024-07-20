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

    // State registers
    state_t current_state, next_state;

    // Output logic (Moore state machine)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                out = 1;
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_A: begin
                out = 0;
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: begin
                next_state = STATE_B; // Default state
            end
        endcase
    end
endmodule
