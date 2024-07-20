module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    reg Y2;
    reg [3:0] Y4;

    always @(y, w) begin
        Y2 = y[1] & ~w;
        Y4 = {y[2], y[3], y[5], y[6]} & w;
    end

    assign Y2 = Y2;
    assign Y4 = Y4[3:0];

endmodule
