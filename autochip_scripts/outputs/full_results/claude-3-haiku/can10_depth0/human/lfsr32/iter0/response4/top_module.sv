module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q[0] = q[0] ^ q[1] ^ q[22] ^ q[31];
    next_q[1] = q[0];
    next_q[2] = q[1];
    next_q[3] = q[2];
    next_q[4] = q[3];
    next_q[5] = q[4];
    next_q[6] = q[5];
    next_q[7] = q[6];
    next_q[8] = q[7];
    next_q[9] = q[8];
    next_q[10] = q[9];
    next_q[11] = q[10];
    next_q[12] = q[11];
    next_q[13] = q[12];
    next_q[14] = q[13];
    next_q[15] = q[14];
    next_q[16] = q[15];
    next_q[17] = q[16];
    next_q[18] = q[17];
    next_q[19] = q[18];
    next_q[20] = q[19];
    next_q[21] = q[20];
    next_q[22] = q[21];
    next_q[23] = q[22];
    next_q[24] = q[23];
    next_q[25] = q[24];
    next_q[26] = q[25];
    next_q[27] = q[26];
    next_q[28] = q[27];
    next_q[29] = q[28];
    next_q[30] = q[29];
    next_q[31] = q[30];
end

endmodule
