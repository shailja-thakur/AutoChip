module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count;

always @(*) begin
    count = 0;
    for (int i = 0; i < 255; i++) begin
        if (in[i]) count = count + 1;
    end
    out = count;
end

endmodule
