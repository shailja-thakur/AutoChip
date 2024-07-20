module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State definitions
    typedef enum logic [2:0] {
        A    = 3'd0,
        B    = 3'd1,
        C    = 3'd2,
        S10  = 3'd3,
        S11  = 3'd4,
        S20  = 3'd5,
        S21  = 3'd6,
        S22  = 3'd7
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A:    next_state = s ? B : A;
            B:    next_state = w ? S11 : S10;
            C:    next_state = w ? S11 : S10;
            S10:  next_state = w ? S21 : S20;
            S11:  next_state = w ? S22 : S21;
            S20:  next_state = B;
            S21:  next_state = w ? C : B;
            S22:  next_state = w ? B : C;
            default: next_state = A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S10, S11, S20, S21, S22: z = 1;
            default: z = 0;
        endcase
    end

endmodule
