module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    case ({a, q})
        // Both a and q are high
        2'b11: q <= 3'b100;
        // a is high and q is not 000
        2'b10: q <= q + 1;
        // a is low and q is not 000
        2'b01: q <= q - 1;
        // Both a and q are low
        2'b00: q <= q;
    endcase
end

endmodule
