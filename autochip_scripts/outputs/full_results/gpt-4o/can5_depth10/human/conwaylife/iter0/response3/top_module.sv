module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [255:0] next_q;

    function integer count_neighbors;
        input [255:0] grid;
        input integer row;
        input integer col;
        integer r, c;
        begin
            count_neighbors = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin // skip the cell itself
                        count_neighbors = count_neighbors + grid[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)];
                    end
                end
            end
        end
    endfunction

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer neighbors = count_neighbors(q, i, j);
                if (neighbors == 3) begin
                    next_q[i * 16 + j] = 1;
                end else if (neighbors == 2) begin
                    next_q[i * 16 + j] = q[i * 16 + j];
                end else begin
                    next_q[i * 16 + j] = 0;
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
    
endmodule
