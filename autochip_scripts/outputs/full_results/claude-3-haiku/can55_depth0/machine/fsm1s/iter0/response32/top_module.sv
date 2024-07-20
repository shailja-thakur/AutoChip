module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= B;
    else
        case (state)
            A: state <= (in) ? A : B;
            B: state <= (in) ? B : A;
        endcase
end

always @* begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
    endcase
end

endmodule
