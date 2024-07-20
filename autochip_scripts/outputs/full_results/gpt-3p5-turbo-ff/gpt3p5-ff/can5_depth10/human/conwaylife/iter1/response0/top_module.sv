module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;

    always @(posedge clk)
    begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end
    
    // Calculate the neighbors for each cell
    always @(*)
    begin
        for (integer i = 0; i < 16; i = i + 1)
        begin
            for (integer j = 0; j < 16; j = j + 1)
            begin
                reg [7:0] neighbors = 0;
                
                // Calculate the indices of the neighbors
                integer top = (i == 0) ? 15 : i - 1;
                integer bottom = (i == 15) ? 0 : i + 1;
                integer left = (j == 0) ? 15 : j - 1;
                integer right = (j == 15) ? 0 : j + 1;
                
                // Calculate the number of alive neighbors
                neighbors[0] = q[top*16 + left];
                neighbors[1] = q[top*16 + j];
                neighbors[2] = q[top*16 + right];
                neighbors[3] = q[i*16 + right];
                neighbors[4] = q[bottom*16 + right];
                neighbors[5] = q[bottom*16 + j];
                neighbors[6] = q[bottom*16 + left];
                neighbors[7] = q[i*16 + left];
                
                // Calculate the next state of the cell
                if (q[i*16 + j])
                begin
                    if (neighbors == 2 || neighbors == 3)
                        q_next[i*16 + j] = 1;
                    else
                        q_next[i*16 + j] = 0;
                end
                else
                begin
                    if (neighbors == 3)
                        q_next[i*16 + j] = 1;
                    else
                        q_next[i*16 + j] = 0;
                end
            end
        end
    end
endmodule
