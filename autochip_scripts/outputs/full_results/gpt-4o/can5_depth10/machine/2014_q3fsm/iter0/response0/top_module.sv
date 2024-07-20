module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declaration
    typedef enum logic [2:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = w ? S11 : S10;
            C: next_state = w ? S11 : S10;
            S10: next_state = w ? S21 : S20;
            S11: next_state = w ? S22 : S21;
            S20: next_state = B;
            S21: next_state = w ? C : B;
            S22: next_state = w ? B : C;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else
            z <= (state == S22);  // Example output based on state S22
    end

endmodule
