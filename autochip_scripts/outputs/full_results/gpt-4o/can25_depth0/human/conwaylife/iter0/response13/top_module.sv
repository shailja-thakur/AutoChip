module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    // Define the integer for loops
    integer i, j;

    // Function to count the number of neighbors for a specific cell
    function integer count_neighbors;
        input [255:0] grid;
        input integer x, y;
        integer xi, yi, sum;
    begin
        sum = 0;
        for (xi = -1; xi <= 1; xi = xi + 1) begin
            for (yi = -1; yi <= 1; yi = yi + 1) begin
                if (xi != 0 || yi != 0) begin
                    // Calculate the wrapped positions
                    sum = sum + grid[(x + xi + 16) % 16 * 16 + (y + yi + 16) % 16];
                end
            end
        end
        count_neighbors = sum;
    end
    endfunction

    // Temporary reg array to store next state
    reg [255:0] next_state;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Loop through all cells to calculate the next state
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(q, i, j))
                        2: next_state[i * 16 + j] = q[i * 16 + j]; // State does not change if 2 neighbors
                        3: next_state[i * 16 + j] = 1; // Becomes alive if 3 neighbors
                        default: next_state[i * 16 + j] = 0; // Becomes dead otherwise
                    endcase
                end
            end
            q <= next_state;
        end
    end
endmodule
