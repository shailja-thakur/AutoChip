module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State enumeration
    // B = 0
    // A = 1
    parameter B = 0;
    parameter A = 1;

    // State variable
    reg [1:0] state;

    // Output assignment
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else if (state == B && in)
            state <= A;
        else if (state == A && !in)
            state <= B;
    end

    // Output logic
    always @(state, in) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
        endcase
    end

endmodule
