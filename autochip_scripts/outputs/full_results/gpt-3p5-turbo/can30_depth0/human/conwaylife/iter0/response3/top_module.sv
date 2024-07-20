module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

reg [255:0] q_next;
reg [7:0] neighbours;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 0; i < 256; i = i + 16) begin
            for (int j = 0; j < 16; j = j + 1) begin
                neighbours = q[i + (j-1)%16] + q[i + (j+1)%16] + q[(i-16+j)%256] + q[(i+16+j)%256] + q[(i-16+j-1)%256] + q[(i-16+j+1)%256] + q[(i+16+j-1)%256] + q[(i+16+j+1)%256];
                if (neighbours <= 1 || neighbours >= 4)
                    q_next[i+j] = 0;
                else if (neighbours == 3)
                    q_next[i+j] = 1;
                else
                    q_next[i+j] = q[i+j];
            end
        end
        q <= q_next;
    end
end

endmodule
