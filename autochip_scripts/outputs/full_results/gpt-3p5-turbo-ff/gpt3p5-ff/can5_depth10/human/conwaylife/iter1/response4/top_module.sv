module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;
    reg [15:0] q_neighbors;
    integer i, j;

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            q <= q_next;
        end
    end

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                // Calculate number of neighbors
                q_neighbors = 
                    q[((i+15)%16)*16 + (j+15)%16] +
                    q[((i+15)%16)*16 + j] +
                    q[((i+15)%16)*16 + (j+1)%16] +
                    q[i*16 + (j+15)%16] +
                    q[i*16 + (j+1)%16] +
                    q[((i+1)%16)*16 + (j+15)%16] +
                    q[((i+1)%16)*16 + j] +
                    q[((i+1)%16)*16 + (j+1)%16];

                // Calculate next state for the cell based on neighbors
                if (q_neighbors == 2)
                    q_next[i*16 + j] = q[i*16 + j];
                else if (q_neighbors == 3)
                    q_next[i*16 + j] = 1;
                else
                    q_next[i*16 + j] = 0;
            end
        end
    end
endmodule
