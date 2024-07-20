module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Declare state encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @ (*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
