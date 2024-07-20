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
    integer i, j, count;
    next_q = q;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            count = 0;
            // Check the 8 neighboring cells
            if (i > 0) begin
                if (q[(i-1)*16 + j] == 1) count = count + 1;
            end
            else begin
                if (q[(15*16) + j] == 1) count = count + 1;
            end
            if (i < 15) begin
                if (q[(i+1)*16 + j] == 1) count = count + 1;
            end
            else begin
                if (q[j] == 1) count = count + 1;
            end
            if (j > 0) begin
                if (q[i*16 + j-1] == 1) count = count + 1;
            end
            else begin
                if (q[i*16 + 15] == 1) count = count + 1;
            end
            if (j < 15) begin
                if (q[i*16 + j+1] == 1) count = count + 1;
            end
            else begin
                if (q[i*16 + 0] == 1) count = count + 1;
            end
            // Apply the rules
            if (q[i*16 + j] == 1) begin
                if (count < 2 || count > 3) begin
                    next_q[i*16 + j] = 0;
                end
            end
            else begin
                if (count == 3) begin
                    next_q[i*16 + j] = 1;
                end
            end
        end
    end
end

endmodule
