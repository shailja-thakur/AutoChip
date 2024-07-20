module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State encoding using one-hot
    reg [1:0] state;
    reg [1:0] next_state;

    // States
    parameter A = 2'b01, B = 2'b10;

    // Output logic
    assign z = (state == A && x == 1) || (state == B && x == 0);

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? B : B; // B stays the same
            default: next_state = A;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
