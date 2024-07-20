module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Function to count alive neighbors of a cell
    function integer count_neighbors;
        input [255:0] grid;
        input integer row, col;
        integer r, c;
        integer count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin
                        count = count + grid[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction
    
    integer i, j, neighbors;
    reg [255:0] new_state;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbors = count_neighbors(q, i, j);
                    if (neighbors < 2 || neighbors > 3) begin
                        new_state[i * 16 + j] = 0;
                    end
                    else if (neighbors == 3) begin
                        new_state[i * 16 + j] = 1;
                    end
                    else begin
                        new_state[i * 16 + j] = q[i * 16 + j];
                    end
                end
            end
            q <= new_state;
        end
    end
endmodule
