module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    reg [255:0] next_q;
    reg [15:0] neighbors;
    reg [15:0] row_nbrs [15:0];
    reg [15:0] col_nbrs [15:0];

    // Generate row neighbors
    integer i, j;
    always @(*)
    begin
        for (i = 0; i < 16; i = i + 1)
        begin
            row_nbrs[i][0] = q[i*16 + 15];
            row_nbrs[i][1] = q[i*16 + 0];
            
            for (j = 2; j < 16; j = j + 1)
            begin
                row_nbrs[i][j] = q[i*16 + (j-1)];
            end
        end
    end

    // Generate column neighbors
    always @(*)
    begin
        for (i = 0; i < 16; i = i + 1)
        begin
            col_nbrs[i][0] = q[i];
            col_nbrs[i][1] = q[i*16];
            col_nbrs[i][2] = q[i*16 + 1];

            for (j = 3; j < 16; j = j + 1)
            begin
                col_nbrs[i][j] = q[i*16 + (j-1)];
            end
        end
    end
    
    // Generate next state based on number of neighbors
    always @(*)
    begin
        for (i = 0; i < 256; i = i + 1)
        begin
            neighbors = row_nbrs[i/16][i%16-1] + row_nbrs[i/16][i%16] + row_nbrs[i/16][(i%16+1)%16];
            neighbors = neighbors + col_nbrs[i%16][i/16-1] + col_nbrs[i%16][i/16] + col_nbrs[i%16][(i/16+1)%16];
            
            if (neighbors <= 1)
                next_q[i] = 0;
            else if (neighbors == 2)
                next_q[i] = q[i];
            else if (neighbors == 3)
                next_q[i] = 1;
            else
                next_q[i] = 0;
        end
    end

    // Synchronous load
    always @(posedge clk)
    begin
        if(load == 1)
            q <= data;
        else
            q <= next_q;
    end

endmodule
