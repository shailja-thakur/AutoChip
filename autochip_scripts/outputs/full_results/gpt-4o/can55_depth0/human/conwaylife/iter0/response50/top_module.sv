module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Function to compute the number of live neighbors for a cell at (x, y)
    function integer count_neighbors;
        input [255:0] grid;
        input integer x, y;
        integer i, j, count;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin
                        // Toroidal wrap-around logic
                        count = count + grid[((x + i + 16) % 16) * 16 + ((y + j + 16) % 16)];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction
    
    // Temporary grid to hold the next state
    reg [255:0] next_q;

    integer x, y, neighbors;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    neighbors = count_neighbors(q, x, y);
                    if ((q[x * 16 + y] == 1 && (neighbors == 2 || neighbors == 3)) || (q[x * 16 + y] == 0 && neighbors == 3)) begin
                        next_q[x * 16 + y] = 1;
                    end
                    else begin
                        next_q[x * 16 + y] = 0;
                    end
                end
            end
            q <= next_q;
        end
    end
endmodule
