module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Helper function to count neighbours
    function [3:0] count_neighbours(
        input [255:0] grid,
        input [3:0] row,
        input [3:0] col
    );
        reg [3:0] count;
        integer i, j;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (!(i == 0 && j == 0)) begin
                        if (grid[((row + i) & 4'hF) * 16 + ((col + j) & 4'hF)] == 1'b1) begin
                            count = count + 1;
                        end
                    end
                end
            end
            count_neighbours = count;
        end
    endfunction

    // Calculate the next state of the game
    always @* begin
        integer r, c;
        reg [3:0] neighbours;
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                neighbours = count_neighbours(q, r, c);
                if (neighbours < 2 || neighbours > 3) begin
                    next_q[r * 16 + c] = 1'b0;
                end else if (neighbours == 3) begin
                    next_q[r * 16 + c] = 1'b1;
                end else begin
                    next_q[r * 16 + c] = q[r * 16 + c];
                end
            end
        end
    end

    // Register update logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
