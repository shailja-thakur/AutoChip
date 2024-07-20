module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
localparam A = 1'b0, B = 1'b1;

always @(*) begin
    case (state)
        A: state = j ? B : A;
        B: state = k ? A : B;
        default: state = A;
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= state;
end

always @(*) begin
    out = (state == B) ? 1'b1 : 1'b0;
end

endmodule
