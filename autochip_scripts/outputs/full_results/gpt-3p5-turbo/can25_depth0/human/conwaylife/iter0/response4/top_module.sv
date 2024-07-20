module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
 
reg [255:0] q_next;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= q_next;
    end
end
 
always @* begin
    for (integer i = 0; i < 256; i = i + 16) begin
        for (integer j = 0; j < 16; j = j + 1) begin
            integer count = q[(i + j + 15) % 256] + q[(i + j + 1) % 256] + q[(i + j + 16) % 256] + q[(i + j + 240) % 256] 
                    + q[(i + j + 16 + 1) % 256] + q[(i + j + 16 + 15) % 256] + q[(i + j + 16 + 16) % 256] + q[(i + j + 16 + 240) % 256];
            if (q[i + j]) begin
                if (count < 2 || count > 3) begin
                    q_next[i + j] = 0;
                end else begin
                    q_next[i + j] = 1;
                end
            end else begin
                if (count == 3) begin
                    q_next[i + j] = 1;
                end else begin
                    q_next[i + j] = 0;
                end
            end
        end
    end
end
 
endmodule
