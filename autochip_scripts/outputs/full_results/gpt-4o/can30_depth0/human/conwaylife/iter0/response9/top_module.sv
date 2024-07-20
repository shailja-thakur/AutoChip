module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    wire [15:0] neighbour_count [15:0]; 
    integer i, j, k, m, n;
    
    // Calculate the number of neighbors for each cell
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbour_count[i][j] = 0;
                for (k = -1; k <= 1; k = k + 1) begin
                    for (m = -1; m <= 1; m = m + 1) begin
                        if (!(k == 0 && m == 0)) begin
                            n = ((i + k) + 16) % 16;
                            l = ((j + m) + 16) % 16;
                            neighbour_count[i][j] = neighbour_count[i][j] + q[16*n + l];
                        end
                    end
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (neighbour_count[i][j] == 3 || (neighbour_count[i][j] == 2 && q[16*i + j] == 1)) begin
                        q[16*i + j] <= 1;
                    end else begin
                        q[16*i + j] <= 0;
                    end
                end
            end
        end
    end

endmodule
