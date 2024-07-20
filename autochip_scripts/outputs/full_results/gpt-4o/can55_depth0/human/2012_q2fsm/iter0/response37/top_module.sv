module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        S_A = 3'd0, 
        S_B = 3'd1, 
        S_C = 3'd2,
        S_D = 3'd3, 
        S_E = 3'd4, 
        S_F = 3'd5
    } state_t;

    state_t current_state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S_A;
        else
            current_state <= next_state;
    end

    // Next state logic (combinatorial logic)
    always @(*) begin
        case (current_state)
            S_A: next_state = (w) ? S_B : S_A;
            S_B: next_state = (w) ? S_C : S_D;
            S_C: next_state = (w) ? S_E : S_D;
            S_D: next_state = (w) ? S_F : S_A;
            S_E: next_state = (w) ? S_E : S_D;
            S_F: next_state = (w) ? S_C : S_D;
            default: next_state = S_A;
        endcase
    end

    // Output logic (combinatorial logic)
    always @(*) begin
        case (current_state)
            S_A: z = 1'b0;
            S_B: z = 1'b0;
            S_C: z = 1'b0;
            S_D: z = 1'b0;
            S_E: z = 1'b1;
            S_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
