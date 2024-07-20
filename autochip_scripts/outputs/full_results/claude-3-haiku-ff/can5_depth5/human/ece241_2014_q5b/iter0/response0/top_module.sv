module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// One-hot state encoding
parameter A = 2'b01, B = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    // Next state logic
    case (state)
        A: next_state = (x) ? B : A;
        B: next_state = (x) ? B : B;
        default: next_state = A;
    endcase

    // Output logic
    case (state)
        A: z = x;
        B: z = ~x;
        default: z = 0;
    endcase
end

endmodule
