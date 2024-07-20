module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Function to compute the index of the wrapped-around neighbor
    function integer wrapped_index(input integer idx, input integer max);
        if (idx < 0) wrapped_index = max + idx;
        else if (idx >= max) wrapped_index = idx - max;
        else wrapped_index = idx;
    endfunction

    // Function to count the number of living neighbors for given cell
    function integer count_neighbors(input reg [255:0] grid, input integer x, input integer y);
        integer count;
        integer i, j;
        count = 0;

        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i != 0 || j != 0) begin
                    count = count + 
                            grid[16 * wrapped_index(y + i, 16) + wrapped_index(x + j, 16)];
                end
            end
        end

        count_neighbors = count;
    endfunction

    // Calculate next state based on the neighbors' count
    always @(*) begin
        integer x, y;
        integer neighbors;

        for (y = 0; y < 16; y = y + 1) begin
            for (x = 0; x < 16; x = x + 1) begin
                neighbors = count_neighbors(q, x, y);
                if (neighbors < 2 || neighbors > 3)
                    next_q[16 * y + x] = 0;
                else if (neighbors == 2)
                    next_q[16 * y + x] = q[16 * y + x];
                else if (neighbors == 3)
                    next_q[16 * y + x] = 1;
            end
        end
    end

    // Update q on clock edge or when load is active
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= next_q;
        end
    end

endmodule
