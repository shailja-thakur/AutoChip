module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum {STATE_A, STATE_B, COUNT_1, COUNT_2, COUNT_3} state_t;
    state_t current_state, next_state;
    reg [1:0] w_count;  // counter for 'w' = 1 in the last three clock cycles
    reg [1:0] cycle_count; // counter for three clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B || current_state == COUNT_1 || current_state == COUNT_2 || current_state == COUNT_3) begin
                if (w) w_count <= w_count + 1;
                cycle_count <= cycle_count + 1;

                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2'b10);
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                end
            end else if (current_state == STATE_A) begin
                w_count <= 2'b00;
                cycle_count <= 2'b00;
                z <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                next_state = COUNT_1;
            end
            COUNT_1: begin
                if (cycle_count == 2'b10)
                    next_state = STATE_A;
                else
                    next_state = COUNT_2;
            end
            COUNT_2: begin
                if (cycle_count == 2'b10)
                    next_state = STATE_A;
                else
                    next_state = COUNT_3;
            end
            COUNT_3: begin
                if (cycle_count == 2'b10)
                    next_state = STATE_A;
                else
                    next_state = COUNT_1;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
