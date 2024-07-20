module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    case ({a, q})
        2'b00: q <= x;
        2'b01: q <= 1'b1;
        2'b10: q <= 1'b0;
        2'b11: q <= q;
    endcase
end

endmodule
