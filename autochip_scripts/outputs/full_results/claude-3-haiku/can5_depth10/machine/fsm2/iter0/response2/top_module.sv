module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        A: state = (j) ? B : A;
        B: state = (k) ? A : B;
        default: state = A;
    endcase
end

// Sequential logic to update state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= state;
end

// Output logic
always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
