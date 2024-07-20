module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(posedge w) begin
        Y1 <= y[1];
        Y3 <= y[3];
    end

endmodule
