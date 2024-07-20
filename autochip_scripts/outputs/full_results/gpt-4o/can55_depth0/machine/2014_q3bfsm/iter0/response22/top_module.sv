module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;

    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? E : B;
            C: next_state = (x) ? B : C;
            D: next_state = (x) ? C : B;
            E: next_state = (x) ? E : D;
            default: next_state = A; // Handle any unexpected state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            D, E: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
