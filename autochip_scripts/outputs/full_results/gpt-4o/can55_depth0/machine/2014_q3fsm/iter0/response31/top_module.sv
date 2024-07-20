module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state names
    typedef enum reg [2:0] {A, B, C, S10, S11, S20, S21, S22} state_t;
    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: if (s) next_state = B; else next_state = A;
            B: if (w) next_state = S11; else next_state = S10;
            C: if (w) next_state = S11; else next_state = S10;
            S10: if (w) next_state = S21; else next_state = S20;
            S11: if (w) next_state = S22; else next_state = S21;
            S20: next_state = B;
            S21: if (w) next_state = C; else next_state = B;
            S22: if (w) next_state = B; else next_state = C;
            default: next_state = A;
        endcase
    end
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else
            case (state)
                B, C, S10, S11, S20, S21, S22: z <= 1;
                default: z <= 0;
            endcase
    end

endmodule
