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
    else if (state == A)
        state <= (in) ? A : B;
    else
        state <= (in) ? B : A;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
