module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Helper functions
    function [15:0] get_neighbors(input [255:0] state, input [7:0] row, input [7:0] col);
        begin
            // Calculate the indices of the neighboring cells
            // Note the toroidal wrapping around the edges
            get_neighbors[0] = state[(((row - 1) % 16) * 16) + ((col - 1) % 16)]; // Top-left
            get_neighbors[1] = state[(((row - 1) % 16) * 16) + (col % 16)];        // Top
            get_neighbors[2] = state[(((row - 1) % 16) * 16) + ((col + 1) % 16)]; // Top-right
            get_neighbors[3] = state[(((row) % 16) * 16) + ((col - 1) % 16)];     // Left
            get_neighbors[4] = state[(((row) % 16) * 16) + ((col + 1) % 16)];     // Right
            get_neighbors[5] = state[(((row + 1) % 16) * 16) + ((col - 1) % 16)]; // Bottom-left
            get_neighbors[6] = state[(((row + 1) % 16) * 16) + (col % 16)];       // Bottom
            get_neighbors[7] = state[(((row + 1) % 16) * 16) + ((col + 1) % 16)]; // Bottom-right
        end
    endfunction

    function [15:0] get_next_state(input [15:0] neighbors, input [15:0] current_state);
        begin
            // Apply the Game of Life rules
            get_next_state = current_state;
            if (current_state == 1'b0) begin
                if (neighbors == 3)
                    get_next_state = 1'b1;
            end else begin
                if (neighbors < 2 || neighbors > 3)
                    get_next_state = 1'b0;
            end
        end
    endfunction

    // Main logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Compute the next state for each cell
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    q[(i * 16) + j] <= get_next_state(get_neighbors(q, i, j), q[(i * 16) + j]);
                end
            end
        end
    end

endmodule
