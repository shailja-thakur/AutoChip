module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

wire [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

wire [15:0] row_0, row_1, row_2, row_3, row_4, row_5, row_6, row_7, row_8, row_9, row_10, row_11, row_12, row_13, row_14, row_15;
assign row_0 = q[15:0];
assign row_1 = q[31:16];
assign row_2 = q[47:32];
assign row_3 = q[63:48];
assign row_4 = q[79:64];
assign row_5 = q[95:80];
assign row_6 = q[111:96];
assign row_7 = q[127:112];
assign row_8 = q[143:128];
assign row_9 = q[159:144];
assign row_10 = q[175:160];
assign row_11 = q[191:176];
assign row_12 = q[207:192];
assign row_13 = q[223:208];
assign row_14 = q[239:224];
assign row_15 = q[255:240];

wire [15:0] next_row_0, next_row_1, next_row_2, next_row_3, next_row_4, next_row_5, next_row_6, next_row_7, next_row_8, next_row_9, next_row_10, next_row_11, next_row_12, next_row_13, next_row_14, next_row_15;

assign next_row_0 = ((row_15 & {16{row_0[14]}}) | (row_0 & ~(row_15 | {16{row_0[14]}}))) & 16'hFFFF;
assign next_row_1 = ((row_0 & {16{row_1[14]}}) | (row_1 & ~(row_0 | {16{row_1[14]}}))) & 16'hFFFF;
assign next_row_2 = ((row_1 & {16{row_2[14]}}) | (row_2 & ~(row_1 | {16{row_2[14]}}))) & 16'hFFFF;
assign next_row_3 = ((row_2 & {16{row_3[14]}}) | (row_3 & ~(row_2 | {16{row_3[14]}}))) & 16'hFFFF;
assign next_row_4 = ((row_3 & {16{row_4[14]}}) | (row_4 & ~(row_3 | {16{row_4[14]}}))) & 16'hFFFF;
assign next_row_5 = ((row_4 & {16{row_5[14]}}) | (row_5 & ~(row_4 | {16{row_5[14]}}))) & 16'hFFFF;
assign next_row_6 = ((row_5 & {16{row_6[14]}}) | (row_6 & ~(row_5 | {16{row_6[14]}}))) & 16'hFFFF;
assign next_row_7 = ((row_6 & {16{row_7[14]}}) | (row_7 & ~(row_6 | {16{row_7[14]}}))) & 16'hFFFF;
assign next_row_8 = ((row_7 & {16{row_8[14]}}) | (row_8 & ~(row_7 | {16{row_8[14]}}))) & 16'hFFFF;
assign next_row_9 = ((row_8 & {16{row_9[14]}}) | (row_9 & ~(row_8 | {16{row_9[14]}}))) & 16'hFFFF;
assign next_row_10 = ((row_9 & {16{row_10[14]}}) | (row_10 & ~(row_9 | {16{row_10[14]}}))) & 16'hFFFF;
assign next_row_11 = ((row_10 & {16{row_11[14]}}) | (row_11 & ~(row_10 | {16{row_11[14]}}))) & 16'hFFFF;
assign next_row_12 = ((row_11 & {16{row_12[14]}}) | (row_12 & ~(row_11 | {16{row_12[14]}}))) & 16'hFFFF;
assign next_row_13 = ((row_12 & {16{row_13[14]}}) | (row_13 & ~(row_12 | {16{row_13[14]}}))) & 16'hFFFF;
assign next_row_14 = ((row_13 & {16{row_14[14]}}) | (row_14 & ~(row_13 | {16{row_14[14]}}))) & 16'hFFFF;
assign next_row_15 = ((row_14 & {16{row_15[14]}}) | (row_15 & ~(row_14 | {16{row_15[14]}}))) & 16'hFFFF;

assign next_q = {next_row_15, next_row_14, next_row_13, next_row_12, next_row_11, next_row_10, next_row_9, next_row_8, next_row_7, next_row_6, next_row_5, next_row_4, next_row_3, next_row_2, next_row_1, next_row_0};

endmodule
