module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count_bits;
integer i;

always @(*) begin
    count_bits = 0;
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i]) begin
            count_bits = count_bits + 1;
        end
    end
    out = count_bits;
end

endmodule
