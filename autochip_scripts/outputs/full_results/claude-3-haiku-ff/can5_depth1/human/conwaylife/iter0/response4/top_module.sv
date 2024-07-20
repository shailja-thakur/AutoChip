module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Helper functions to calculate the number of alive neighbors for a cell
    function integer get_left_neighbor(input integer idx);
        return (idx % 16 == 0) ? idx + 15 : idx - 1;
    endfunction

    function integer get_right_neighbor(input integer idx);
        return (idx % 16 == 15) ? idx - 15 : idx + 1;
    endfunction

    function integer get_top_neighbor(input integer idx);
        return (idx < 16) ? idx + 240 : idx - 16;
    endfunction

    function integer get_bottom_neighbor(input integer idx);
        return (idx >= 240) ? idx - 240 : idx + 16;
    endfunction

    function integer count_neighbors(input integer idx);
        integer neighbors = 0;
        neighbors += q[get_left_neighbor(idx)];
        neighbors += q[get_right_neighbor(idx)];
        neighbors += q[get_top_neighbor(idx)];
        neighbors += q[get_bottom_neighbor(idx)];
        return neighbors;
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (integer i = 0; i < 256; i++) begin
                integer neighbors = count_neighbors(i);
                if (neighbors == 2) begin
                    // Cell state does not change
                end else if (neighbors == 3) begin
                    q[i] <= 1;
                end else begin
                    q[i] <= 0;
                end
            end
        end
    end

endmodule
