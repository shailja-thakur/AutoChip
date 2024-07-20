module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);
    always @(*) begin
        // Y2 corresponds to state B (000010) and C (000100)
        Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[6] & ~w);

        // Y4 corresponds to state D (001000)
        Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[6] & w);
    end
endmodule
