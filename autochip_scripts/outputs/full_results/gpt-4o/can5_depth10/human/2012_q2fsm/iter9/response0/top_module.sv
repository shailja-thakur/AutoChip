module top_module (
    input clk,
    input reset,
    input w,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state;

    // State flip-flops (sequential logic)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // State table (combinational logic)
    always_comb begin
        next_state = state; // Default assignment to prevent latches
        case (state)
            A: if (w) next_state = B; else next_state = A;
            B: if (w) next_state = C; else next_state = D;
            C: if (w) next_state = E; else next_state = D;
            D: if (w) next_state = F; else next_state = A;
            E: if (w) next_state = E; else next_state = D;
            F: if (w) next_state = C; else next_state = D;
        endcase
    end

    // Output logic for z
    always_comb begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
