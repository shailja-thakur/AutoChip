module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count;
integer i;

always @(*) begin
    count = 0;
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i]) count = count + 1;
    end
    out = count;
end

endmodule
