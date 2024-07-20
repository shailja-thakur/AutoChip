module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count [0:254];
integer i;

always @(*) begin
    out = 0;
    for (i = 0; i < 255; i = i + 1) begin
        out = out + count[i];
    end
end

always @(*) begin
    for (i = 0; i < 255; i = i + 1) begin
        count[i] = in[i];
    end
end

endmodule
