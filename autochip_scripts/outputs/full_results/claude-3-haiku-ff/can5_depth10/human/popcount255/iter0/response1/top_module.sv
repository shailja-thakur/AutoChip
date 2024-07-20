module top_module (
    input [254:0] in,
    output reg [7:0] out
);

wire [7:0] count_1, count_2, count_3, count_4, count_5;

// Stage 1: Count 1's in each 51-bit group
assign count_1 = {1'b0, $unsigned(in[50:0])};
assign count_2 = {1'b0, $unsigned(in[101:51])};
assign count_3 = {1'b0, $unsigned(in[152:102])};
assign count_4 = {1'b0, $unsigned(in[203:153])};
assign count_5 = {1'b0, $unsigned(in[254:204])};

// Stage 2: Add up the counts from Stage 1
wire [8:0] sum_1, sum_2, sum_3, sum_4;
assign sum_1 = count_1 + count_2;
assign sum_2 = count_3 + count_4;
assign sum_3 = sum_1 + sum_2;
assign sum_4 = sum_3 + count_5;

// Stage 3: Output the final 8-bit count
always @(*) begin
    out = sum_4[7:0];
end

endmodule
