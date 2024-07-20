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

    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_A;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition table
    always @(*) begin
        case (current_state)
            S_A: if (w) next_state = S_B; else next_state = S_A;
            S_B: if (w) next_state = S_C; else next_state = S_D;
            S_C: if (w) next_state = S_E; else next_state = S_D;
            S_D: if (w) next_state = S_F; else next_state = S_A;
            S_E: if (w) next_state = S_E; else next_state = S_D;
            S_F: if (w) next_state = S_C; else next_state = S_D;
            default: next_state = S_A; // default case
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S_A, S_B, S_C, S_D: z = 0;
            S_E, S_F: z = 1;
            default: z = 0; // default case
        endcase
    end

endmodule
