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
            neighbors += q[(i-1)%256]; // Left
            neighbors += q[(i+1)%256]; // Right
            neighbors += q[(i-16)%256]; // Up
            neighbors += q[(i+16)%256]; // Down
            neighbors += q[(i-17)%256]; // Up-Left
            neighbors += q[(i+17)%256]; // Down-Right
            neighbors += q[(i-15)%256]; // Up-Right
            neighbors += q[(i+15)%256]; // Down-Left

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
