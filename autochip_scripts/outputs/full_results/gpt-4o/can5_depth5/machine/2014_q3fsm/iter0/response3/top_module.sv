module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // Define state encoding
    typedef enum logic [2:0] {
        S_A = 3'b000, S_B = 3'b001, S_C = 3'b010, 
        S_S10 = 3'b011, S_S11 = 3'b100, 
        S_S20 = 3'b101, S_S21 = 3'b110, S_S22 = 3'b111
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_A: next_state = (s) ? S_B : S_A;
            S_B: next_state = (w) ? S_S11 : S_S10;
            S_C: next_state = (w) ? S_S11 : S_S10;
            S_S10: next_state = (w) ? S_S21 : S_S20;
            S_S11: next_state = (w) ? S_S22 : S_S21;
            S_S20: next_state = S_B;
            S_S21: next_state = (w) ? S_C : S_B;
            S_S22: next_state = (w) ? S_B : S_C;
            default: next_state = S_A; // Default state
        endcase
    end

    // State registers
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S_S10, S_S11, S_S20, S_S21, S_S22: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
