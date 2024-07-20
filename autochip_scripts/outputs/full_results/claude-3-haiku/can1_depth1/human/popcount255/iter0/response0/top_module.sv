module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [7:0] count_1, count_2, count_3, count_4, count_5;

// Level 1 - Count 1's in groups of 51 bits
popcount_51 pc1 (.in(in[50:0]),   .out(count_1));
popcount_51 pc2 (.in(in[101:51]),  .out(count_2));
popcount_51 pc3 (.in(in[152:102]), .out(count_3));
popcount_51 pc4 (.in(in[203:153]), .out(count_4));
popcount_51 pc5 (.in(in[254:204]), .out(count_5));

// Level 2 - Sum the 5 partial counts
wire [9:0] sum;
assign sum = count_1 + count_2 + count_3 + count_4 + count_5;

// Level 3 - Assign the 8-bit output
always @(*) begin
    out = sum[7:0];
end

endmodule
module popcount_51 (
    input [50:0] in,
    output reg [7:0] out
);

integer i;
always @(*) begin
    out = 0;
    for (i = 0; i < 51; i = i + 1) begin
        out = out + in[i];
    end
end

endmodule
