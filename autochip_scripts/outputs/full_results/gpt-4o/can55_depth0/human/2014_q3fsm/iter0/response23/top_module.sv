module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [1:0] count_w_ones; // Counts the number of times w = 1 in three cycles

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
            count_w_ones <= 2'b00;
            z <= 1'b0;
        end
        else begin
            current_state <= next_state;
            if (next_state == STATE_A) begin
                count_w_ones <= 2'b00;
            end else if (current_state == STATE_B) begin
                count_w_ones <= count_w_ones + w;
            end
            if (current_state == STATE_D) begin
                z <= (count_w_ones == 2);
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (s) next_state = STATE_B;
                else next_state = STATE_A;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                next_state = STATE_D;
            end
            STATE_D: begin
                next_state = STATE_B; // Loop back to state B to continue checking in the next three cycles
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
