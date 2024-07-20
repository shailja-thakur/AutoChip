module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;  // Counter for counting 'w' = 1 in the three clock cycles

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;

            // Only count w if in STATE_B
            if (state == STATE_B || state == STATE_C || state == STATE_D) begin
                if (w) w_count <= w_count + 1;
            end else begin
                w_count <= 2'b00;
            end

            // Set output z at certain condition
            if (state == STATE_D) begin
                if (w_count == 2) z <= 1;
                else z <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (s == 1) next_state = STATE_B;
                else next_state = STATE_A;
            end
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end

endmodule
