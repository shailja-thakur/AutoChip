module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State encoding: Use one-hot or binary encoding as preferred
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;

    // State flip-flops
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Reset state is A
        else
            state <= next_state;
    end

    // State table
    always_comb begin
        case (state)
            A: begin
                if (w)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
            C: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            D: begin
                if (w)
                    next_state = F;
                else
                    next_state = A;
            end
            E: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            F: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
            default: next_state = A; // Default state
        endcase
    end

    // FSM output
    always_comb begin
        case (state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
            default: z = 0; // Default output
        endcase
    end

endmodule
