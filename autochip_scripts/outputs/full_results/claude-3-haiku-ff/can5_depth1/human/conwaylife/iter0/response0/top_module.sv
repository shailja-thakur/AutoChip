module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions to wrap the grid
function int get_neighbor_count(input [255:0] state, input integer row, input integer col);
    integer i, j;
    integer count = 0;
    for (i = -1; i <= 1; i++) begin
        for (j = -1; j <= 1; j++) begin
            if (!(i == 0 && j == 0)) begin
                int new_row = (row + i + 16) % 16;
                int new_col = (col + j + 16) % 16;
                count += state[new_row * 16 + new_col];
            end
        end
    end
    return count;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int neighbor_count = get_neighbor_count(q, i, j);
                if (q[i * 16 + j] == 1) begin
                    if (neighbor_count < 2 || neighbor_count > 3) begin
                        q[i * 16 + j] <= 0;
                    end
                end else begin
                    if (neighbor_count == 3) begin
                        q[i * 16 + j] <= 1;
                    end
                end
            end
        end
    end
end

endmodule
