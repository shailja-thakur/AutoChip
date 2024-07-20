module top_module (
    input [99:0] in,
    output reg [99:0] out
);

always @(*) begin
    out = in;
    out[99:0] = in[0:99];
end

endmodule
