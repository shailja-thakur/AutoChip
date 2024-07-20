module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [15:0] grid[15:0];
reg [15:0] next_grid[15:0];

integer i, j;

always @(posedge clk) begin
    if (load) begin
        q <= data;
        for (i = 0; i < 16; i++) begin
            grid[i] <= data[16*i+:16];
        end
    end
    else begin
        for (i = 0; i < 16; i++) begin
            for (j = 0; j < 16; j++) begin
                next_grid[i][j] = get_next_state(i, j);
            end
        end
        for (i = 0; i < 16; i++) begin
            grid[i] <= next_grid[i];
            q[16*i+:16] <= next_grid[i];
        end
    end
end

function [0:0] get_next_state;
    input [4:0] row;
    input [4:0] col;
    reg [0:0] alive_neighbors;
    begin
        alive_neighbors = 0;
        if (grid[(row-1+16)%16][col-1+16] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[(row-1+16)%16][col] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[(row-1+16)%16][col+1] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[row][col-1] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[row][col+1] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[(row+1)%16][col-1] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[(row+1)%16][col] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[(row+1)%16][col+1] == 1) alive_neighbors = alive_neighbors + 1;
        if (grid[row][col] == 1 && (alive_neighbors == 2 || alive_neighbors == 3)) begin
            get_next_state = 1;
        end
        else if (grid[row][col] == 0 && alive_neighbors == 3) begin
            get_next_state = 1;
        end
        else begin
            get_next_state = 0;
        end
    end
endfunction

endmodule
