module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

    // State declarations
    typedef enum reg [2:0] {
        A,
        B,
        C,
        S10,
        S11,
        S20,
        S21,
        S22
    } state_t;
	
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = s ? B : A;
            B: next_state = w ? S11 : S10;
            C: next_state = w ? S11 : S10;
            S10: next_state = w ? S21 : S20;
            S11: next_state = w ? S22 : S21;
            S20: next_state = B;
            S21: next_state = w ? C : B;
            S22: next_state = w ? B : C;
            default: next_state = A;  // Default state is A
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == S11 || state == S21);
    end

endmodule
