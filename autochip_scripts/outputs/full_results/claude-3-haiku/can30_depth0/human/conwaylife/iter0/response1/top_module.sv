module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Define the neighborhood function
    function [8:0] get_neighbors(input [255:0] state, input [7:0] row, input [7:0] col);
        wire [7:0] r_prev = (row == 0) ? 15 : row - 1;
        wire [7:0] r_next = (row == 15) ? 0 : row + 1;
        wire [7:0] c_prev = (col == 0) ? 15 : col - 1;
        wire [7:0] c_next = (col == 15) ? 0 : col + 1;

        get_neighbors = {
            state[r_prev * 16 + c_prev],
            state[r_prev * 16 + col],
            state[r_prev * 16 + c_next],
            state[row * 16 + c_prev],
            state[row * 16 + c_next],
            state[r_next * 16 + c_prev],
            state[r_next * 16 + col],
            state[r_next * 16 + c_next]
        };
    endfunction

    // Update the game state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    wire [8:0] neighbors = get_neighbors(q, i, j);
                    wire [3:0] live_neighbors = neighbors[8:0];
                    if (q[i * 16 + j]) begin
                        // Rule 2 and 4
                        q[i * 16 + j] <= (live_neighbors == 2 || live_neighbors == 3);
                    end else begin
                        // Rule 1 and 3
                        q[i * 16 + j] <= (live_neighbors == 3);
                    end
                end
            end
        end
    end

endmodule
