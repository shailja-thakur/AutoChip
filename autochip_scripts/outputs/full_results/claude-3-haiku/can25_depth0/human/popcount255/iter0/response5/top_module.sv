module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count_bits [0:254];
integer i;

always @(*) begin
    for (i = 0; i < 255; i = i + 1) begin
        count_bits[i] = {8{in[i]}};
    end
    out = 0;
    for (i = 0; i < 255; i = i + 1) begin
        out = out + count_bits[i];
    end
end

endmodule
