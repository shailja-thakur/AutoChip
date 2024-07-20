module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper function to get the number of neighbors for a given cell
function int get_num_neighbors(input [255:0] grid, input integer x, input integer y);
    integer i, j;
    int count = 0;
    for (i = -1; i <= 1; i++) begin
        for (j = -1; j <= 1; j++) begin
            if (!(i == 0 && j == 0)) begin
                int nx = (x + i + 16) % 16;
                int ny = (y + j + 16) % 16;
                count += grid[nx + 16*ny];
            end
        end
    end
    return count;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int num_neighbors = get_num_neighbors(q, i, j);
                if (num_neighbors < 2 || num_neighbors > 3) begin
                    q[i + 16*j] <= 0;
                end
                else if (num_neighbors == 3) begin
                    q[i + 16*j] <= 1;
                end
            end
        end
    end
end

endmodule
