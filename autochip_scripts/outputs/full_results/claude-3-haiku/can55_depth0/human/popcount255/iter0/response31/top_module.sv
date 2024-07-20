module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count [0:254];
integer i;

always @(*) begin
    out = 0;
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i]) begin
            out = out + count[i];
        end
    end
end

initial begin
    for (i = 0; i < 255; i = i + 1) begin
        count[i] = 1;
        if (i > 0) begin
            count[i] = count[i-1] + 1;
        end
    end
end

endmodule
