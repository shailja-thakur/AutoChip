module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter A = 0, B = 1;
reg state;
assign out = state;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else if (state == A && in)
        state <= A;
    else if (state == A && !in)
        state <= B;
    else if (state == B && in)
        state <= B;
    else if (state == B && !in)
        state <= A;
end

endmodule
