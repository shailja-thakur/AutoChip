module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [31:0] count_32bit[7:0];

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        population_count_32bit pc(
            .in(in[(i+1)*32-1:i*32]),
            .out(count_32bit[i])
        );
    end
endgenerate

always @(*) begin
    out = 0;
    for (int i = 0; i < 8; i = i + 1) begin
        out += count_32bit[i];
    end
end

module population_count_32bit (
    input [31:0] in,
    output reg [7:0] out
);

reg [15:0] count_16bit[1:0];

always @(*) begin
    count_16bit[0] = $countones(in[15:0]);
    count_16bit[1] = $countones(in[31:16]);
    out = count_16bit[0] + count_16bit[1];
end

endmodule
