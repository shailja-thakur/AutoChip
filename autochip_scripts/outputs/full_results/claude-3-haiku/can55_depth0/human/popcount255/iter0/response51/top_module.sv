module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Use a tree of adders to count the population
wire [31:0] count_1;
wire [15:0] count_2;
wire [7:0] count_3;

// Level 1: Count groups of 8 bits
genvar i;
generate
    for (i = 0; i < 32; i++) begin
        assign count_1[i] = $countones(in[8*i +: 8]);
    end
endgenerate

// Level 2: Add up the groups of 8 bits
assign count_2[0] = $countones(count_1[7:0]);
assign count_2[1] = $countones(count_1[15:8]);
assign count_2[2] = $countones(count_1[23:16]);
assign count_2[3] = $countones(count_1[31:24]);
assign count_2[4] = $countones(count_1[39:32]);
assign count_2[5] = $countones(count_1[47:40]);
assign count_2[6] = $countones(count_1[55:48]);
assign count_2[7] = $countones(count_1[63:56]);
assign count_2[8] = $countones(count_1[71:64]);
assign count_2[9] = $countones(count_1[79:72]);
assign count_2[10] = $countones(count_1[87:80]);
assign count_2[11] = $countones(count_1[95:88]);
assign count_2[12] = $countones(count_1[103:96]);
assign count_2[13] = $countones(count_1[111:104]);
assign count_2[14] = $countones(count_1[119:112]);
assign count_2[15] = $countones(count_1[127:120]);

// Level 3: Add up the groups of 16 bits
assign count_3[0] = $countones(count_2[7:0]);
assign count_3[1] = $countones(count_2[15:8]);
assign count_3[2] = $countones(count_1[135:128]);
assign count_3[3] = $countones(count_1[143:136]);
assign count_3[4] = $countones(count_1[151:144]);
assign count_3[5] = $countones(count_1[159:152]);
assign count_3[6] = $countones(count_1[167:160]);
assign count_3[7] = $countones(count_1[175:168]);

// Final output
always @(*) begin
    out = count_3;
end

endmodule
