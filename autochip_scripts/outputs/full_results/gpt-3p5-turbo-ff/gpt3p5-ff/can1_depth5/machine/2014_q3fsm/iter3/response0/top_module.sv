module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define the states
    typedef enum logic [3:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;

    // Define the current and next states
    state_t current_state, next_state;

    // State transitions and outputs
    always_comb begin
        case (current_state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            end
            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            end
            S20: next_state = B;
            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
            end
            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
            end
        endcase
    end

    // Output z
    always_ff @(posedge clk) begin
        case (current_state)
            A, B, C, S10, S20: z <= 0;
            S11, S21, S22: z <= 1;
        endcase
    end

endmodule
