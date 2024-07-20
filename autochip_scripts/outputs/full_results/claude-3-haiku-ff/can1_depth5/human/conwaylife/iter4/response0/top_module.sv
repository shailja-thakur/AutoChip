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
        for (int i = 0; i < 256; i++) begin
            int neighbors = 0;
            neighbors += (i > 0) ? q[(i-1)%256] : 0; // Left
            neighbors += (i < 255) ? q[(i+1)%256] : 0; // Right
            neighbors += (i >= 16) ? q[(i-16)%256] : 0; // Up
            neighbors += (i < 240) ? q[(i+16)%256] : 0; // Down
            neighbors += (i > 15) ? q[(i-17)%256] : 0; // Up-Left
            neighbors += (i < 239) ? q[(i+17)%256] : 0; // Down-Right
            neighbors += (i >= 16 && i < 240) ? q[(i-15)%256] : 0; // Up-Right
            neighbors += (i >= 15 && i < 241) ? q[(i+15)%256] : 0; // Down-Left

            if (neighbors == 0 || neighbors == 1) begin
                next_q[i] = 0;
            end
            else if (neighbors == 2) begin
                next_q[i] = q[i];
            end
            else if (neighbors == 3) begin
                next_q[i] = 1;
            end
            else begin
                next_q[i] = 0;
            end
        end
    end

endmodule
