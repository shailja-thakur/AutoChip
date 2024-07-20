module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    typedef enum logic [2:0] {
        S_A = 3'b000,
        S_B = 3'b001,
        S_C = 3'b010,
        S_D = 3'b011,
        S_E = 3'b100,
        S_F = 3'b101
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S_A: next_state = (w) ? S_A : S_B;
            S_B: next_state = (w) ? S_D : S_C;
            S_C: next_state = (w) ? S_D : S_E;
            S_D: next_state = (w) ? S_A : S_F;
            S_E: next_state = (w) ? S_D : S_E;
            S_F: next_state = (w) ? S_D : S_C;
            default: next_state = S_A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= S_A;
        else current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S_E, S_F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
