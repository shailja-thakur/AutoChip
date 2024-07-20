module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define the states
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Output logic
    assign z = (current_state == STATE_E) || (current_state == STATE_F);

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_A : STATE_B;
            STATE_B: next_state = (w) ? STATE_D : STATE_C;
            STATE_C: next_state = (w) ? STATE_D : STATE_E;
            STATE_D: next_state = (w) ? STATE_A : STATE_F;
            STATE_E: next_state = (w) ? STATE_D : STATE_E;
            STATE_F: next_state = (w) ? STATE_D : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

endmodule
