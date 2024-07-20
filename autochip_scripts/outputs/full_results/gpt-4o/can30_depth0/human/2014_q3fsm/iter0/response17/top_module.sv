module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {A, B, C} state_t;
    state_t state, next_state;

    reg [1:0] w_cnt; // counter for 'w' input, to check for exactly two '1's.
    reg [1:0] cycle_cnt; // counter for 3 clock cycles in state B

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                if (cycle_cnt == 2) begin
                    if (w_cnt == 2)
                        z = 1;
                    else
                        z = 0;
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end

            default: next_state = A;
        endcase
    end

    // Output logic and cycle counter logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_cnt <= 0;
            cycle_cnt <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == A) begin
                w_cnt <= 0;
                cycle_cnt <= 0;
                z <= 0;
            end else if (state == B) begin
                cycle_cnt <= cycle_cnt + 1;
                if (w)
                    w_cnt <= w_cnt + 1;
                if (cycle_cnt == 2) begin
                    cycle_cnt <= 0; // reset cycle counter after 3rd cycle
                    w_cnt <= 0; // reset w counter for next set of 3 cycles
                end
            end
        end
    end

endmodule
