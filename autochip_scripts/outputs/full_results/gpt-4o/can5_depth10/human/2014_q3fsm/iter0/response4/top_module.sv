module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,     // Initial state
        B = 2'b01,     // Begin checking `w`
        C = 2'b10      // Continuation of checking `w`
    } state_t;

    state_t state, next_state;

    logic [1:0] w_count;    // Counts of `w` being 1 during three clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                A: begin
                    z <= 0; // Reset output
                end
                B: begin
                    // if we just moved to state B, reset count of `w`
                    w_count <= 2'b00;
                    z <= 0;
                end
                C: begin
                    // Count the number of `w=1`; we assume this is C.
                    if (w == 1)
                        w_count <= w_count + 1;

                    // Once three cycles pass (third cycle), decide on `z`
                    if (state == C) begin
                        if (w_count == 2)
                            z <= 1;
                        else
                            z <= 0;
                        // Reset w_count after decision
                        w_count <= 2'b00;
                    end
                end
            endcase
        end
    end

    // State transition logic
    always_comb begin
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = C;
            end
            C: begin
                if (w_count == 3)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A;
        endcase
    end

endmodule
