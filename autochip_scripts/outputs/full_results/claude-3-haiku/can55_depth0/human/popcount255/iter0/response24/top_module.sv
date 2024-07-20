module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [7:0] count1, count2, count3, count4, count5;

population_count_64 u1 (.in(in[63:0]), .out(count1));
population_count_64 u2 (.in(in[127:64]), .out(count2));
population_count_64 u3 (.in(in[191:128]), .out(count3));
population_count_64 u4 (.in(in[254:192]), .out(count4));

assign count5 = count1 + count2 + count3 + count4;

always @(*) begin
    out = count5;
end

endmodule
module population_count_64 (
    input [63:0] in,
    output reg [7:0] out
);

integer i;

always @(*) begin
    out = 0;
    for (i = 0; i < 64; i = i + 1) begin
        out = out + in[i];
    end
end

endmodule
