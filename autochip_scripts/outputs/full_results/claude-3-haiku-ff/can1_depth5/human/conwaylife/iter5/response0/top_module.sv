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
            if (i > 0) neighbors += q[(i-1)%256]; // Left
            if (i < 255) neighbors += q[(i+1)%256]; // Right
            if (i >= 16) neighbors += q[(i-16)%256]; // Up
            if (i < 240) neighbors += q[(i+16)%256]; // Down
            if (i > 15) neighbors += q[(i-17)%256]; // Up-Left
            if (i < 239) neighbors += q[(i+17)%256]; // Down-Right
            if (i >= 16 && i < 240) neighbors += q[(i-15)%256]; // Up-Right
            if (i >= 15 && i < 241) neighbors += q[(i+15)%256]; // Down-Left

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
