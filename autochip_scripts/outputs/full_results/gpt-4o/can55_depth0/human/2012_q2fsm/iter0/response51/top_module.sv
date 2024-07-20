module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declarations
    typedef enum logic [2:0] {
        S_A = 3'b000,
        S_B = 3'b001,
        S_C = 3'b010,
        S_D = 3'b011,
        S_E = 3'b100,
        S_F = 3'b101
    } state_t;

    state_t state, next_state;

    // State flip-flops (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S_A;
        else
            state <= next_state;
    end

    // State transition table (combinational)
    always_comb begin
        case (state)
            S_A: if (w) next_state = S_B; else next_state = S_A;
            S_B: if (w) next_state = S_C; else next_state = S_D;
            S_C: if (w) next_state = S_E; else next_state = S_D;
            S_D: if (w) next_state = S_F; else next_state = S_A;
            S_E: if (w) next_state = S_E; else next_state = S_D;
            S_F: if (w) next_state = S_C; else next_state = S_D;
            default: next_state = S_A; // Failsafe state
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            S_A, S_B, S_C, S_D: z = 1'b0;
            S_E, S_F: z = 1'b1;
            default: z = 1'b0; // Failsafe output
        endcase
    end

endmodule
