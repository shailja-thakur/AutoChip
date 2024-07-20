module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        case (state)
            A: state <= in ? A : B;
            B: state <= in ? B : A;
            default: state <= B;
        endcase
end

assign out = (state == B);

endmodule
