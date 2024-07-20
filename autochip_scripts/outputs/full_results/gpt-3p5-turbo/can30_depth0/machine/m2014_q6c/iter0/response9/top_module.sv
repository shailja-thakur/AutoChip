module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        Y2 = ~(w) & y[1];
        Y4 = w & y[6] & y[5] & y[3] & y[2];
    end

endmodule
