module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    // Compute next_q based on the current state q
    next_q[255:240] = {q[253:240], q[15:0]};
    next_q[239:224] = {q[237:224], q[31:16]};
    next_q[223:208] = {q[221:208], q[47:32]};
    next_q[207:192] = {q[205:192], q[63:48]};
    next_q[191:176] = {q[189:176], q[79:64]};
    next_q[175:160] = {q[173:160], q[95:80]};
    next_q[159:144] = {q[157:144], q[111:96]};
    next_q[143:128] = {q[141:128], q[127:112]};
    next_q[127:112] = {q[125:112], q[143:128]};
    next_q[111:96] = {q[109:96], q[159:144]};
    next_q[95:80] = {q[93:80], q[175:160]};
    next_q[79:64] = {q[77:64], q[191:176]};
    next_q[63:48] = {q[61:48], q[207:192]};
    next_q[47:32] = {q[45:32], q[223:208]};
    next_q[31:16] = {q[29:16], q[239:224]};
    next_q[15:0] = {q[13:0], q[255:240]};

    // Compute the game of life rules
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i > 0) neighbors += q[i-1];
        if (i < 255) neighbors += q[i+1];
        if (i >= 16) neighbors += q[i-16];
        if (i < 240) neighbors += q[i+16];
        if (i >= 17) neighbors += q[i-17];
        if (i < 239) neighbors += q[i+17];
        if (i >= 16) neighbors += q[i-15];
        if (i < 240) neighbors += q[i+15];

        if (q[i] == 1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_q[i] = 0;
            end
            else begin
                next_q[i] = 1;
            end
        end
        else begin
            if (neighbors == 3) begin
                next_q[i] = 1;
            end
            else begin
                next_q[i] = 0;
            end
        end
    end
end

endmodule
