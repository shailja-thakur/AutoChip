module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State encoding
    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;

    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? E : B;
            C: next_state = (x) ? B : C;
            D: next_state = (x) ? C : B;
            E: next_state = (x) ? E : D;
            default: next_state = A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Initialize state to A
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0; // Initialize output to 0 on reset
        else
            z <= (state == D || state == E) ? 1'b1 : 1'b0;
    end

endmodule
