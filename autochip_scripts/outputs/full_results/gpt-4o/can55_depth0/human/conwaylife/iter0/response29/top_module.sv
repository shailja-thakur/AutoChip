module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    // Current and next state of the grid
    reg [255:0] next_q;

    // Function to count neighbours considering toroidal wrapping
    function [3:0] count_neighbours;
        input [255:0] grid;
        input [3:0] x;
        input [3:0] y;
        integer i, j;
        integer xi, yj;
        begin
            count_neighbours = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (!(i == 0 && j == 0)) begin
                        xi = (x + i) & 4'd15; // Wrap around horizontally
                        yj = (y + j) & 4'd15; // Wrap around vertically
                        count_neighbours = count_neighbours + grid[xi*16 + yj];
                    end
                end
            end
        end
    endfunction

    // Calculate next state of the grid
    integer x, y;
    reg [3:0] neighbours;
    always @(*) begin
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                neighbours = count_neighbours(q, x, y);
                if (q[x*16 + y]) begin
                    if (neighbours < 2 || neighbours > 3) // Rule 1, 4
                        next_q[x*16 + y] = 0;
                    else // Rule 2
                        next_q[x*16 + y] = q[x*16 + y];
                end else begin
                    if (neighbours == 3) // Rule 3
                        next_q[x*16 + y] = 1;
                    else
                        next_q[x*16 + y] = q[x*16 + y];
                end
            end
        end
    end

    // Update the grid at each clock cycle or load data
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule
