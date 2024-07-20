module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    case (q)
        0: if (a == 1'b0) q <= 1'b1;
        1: if (a == 1'b0) q <= 1'b1;
        1: if (a == 1'b1) q <= 1'b0;
        default: q <= q;
    endcase
end

endmodule
