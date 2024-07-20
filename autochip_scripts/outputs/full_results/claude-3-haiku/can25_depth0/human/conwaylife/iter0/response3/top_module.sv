module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions to get the neighbors
function [255:0] get_neighbors(input [255:0] state, input [7:0] row, input [7:0] col);
    reg [255:0] neighbors;
    integer i, j;
    begin
        neighbors = 0;
        for (i = row - 1; i <= row + 1; i = i + 1) begin
            for (j = col - 1; j <= col + 1; j = j + 1) begin
                if (!(i == row && j == col)) begin
                    neighbors[16 * ((i + 16) % 16) + ((j + 16) % 16)] = state[16 * ((i + 16) % 16) + ((j + 16) % 16)];
                end
            end
        end
    end
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (integer i = 0; i < 16; i = i + 1) begin
            for (integer j = 0; j < 16; j = j + 1) begin
                reg [7:0] num_neighbors;
                num_neighbors = $countones(get_neighbors(q, i, j));
                if (q[16 * i + j] == 1'b1) begin
                    if (num_neighbors < 2 || num_neighbors > 3) begin
                        q[16 * i + j] = 1'b0;
                    end
                end else begin
                    if (num_neighbors == 3) begin
                        q[16 * i + j] = 1'b1;
                    end
                end
            end
        end
    end
end

endmodule
