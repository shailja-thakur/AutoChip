module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter A = 0, B = 1;
reg state;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        case (state)
            A: state <= (in) ? A : B;
            B: state <= (in) ? B : A;
        endcase
end

assign out = (state == B);

endmodule
