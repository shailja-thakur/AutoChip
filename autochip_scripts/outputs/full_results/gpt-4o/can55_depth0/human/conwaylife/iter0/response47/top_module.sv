module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Intermediate variables to store the next state of the grid.
    reg [15:0] next_q [15:0]; // 2D array for easier indexing.

    // Convert the linear data array into a 2D array.
    integer i, j;
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                next_q[i][j] = q[i*16 + j];
            end
        end
    end

    // Function to count the number of alive neighbours.
    function integer count_neighbours;
        input integer x, y;
        integer xi, yi, count;
        begin
            count = 0;
            for (xi = -1; xi <= 1; xi = xi + 1) begin
                for (yi = -1; yi <= 1; yi = yi + 1) begin
                    if (!(xi == 0 && yi == 0)) begin
                        count = count + next_q[(x + xi + 16) % 16][(y + yi + 16) % 16];
                    end
                end
            end
            count_neighbours = count;
        end
    endfunction

    // Compute the next state of the grid.
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Loading initial state.
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(i, j))
                        2: next_q[i][j] = next_q[i][j];      // No change
                        3: next_q[i][j] = 1;                 // Cell becomes alive
                        default: next_q[i][j] = 0;            // Cell dies
                    endcase
                end
            end
            
            // Convert the 2D array back to the linear 'q'.
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q[i*16 + j] = next_q[i][j];
                end
            end
        end
    end
endmodule
