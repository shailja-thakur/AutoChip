module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        S_A = 3'b000,
        S_B = 3'b001,
        S_C = 3'b010,
        S_D = 3'b011,
        S_E = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            S_A: if (x) next_state = S_B; else next_state = S_A;
            S_B: if (x) next_state = S_E; else next_state = S_B;
            S_C: if (x) next_state = S_B; else next_state = S_C;
            S_D: if (x) next_state = S_C; else next_state = S_B;
            S_E: if (x) next_state = S_E; else next_state = S_D;
            default: next_state = S_A; // Default case to handle undefined states
        endcase
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S_A; // Initialize state to A on reset
        else 
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S_D, S_E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
