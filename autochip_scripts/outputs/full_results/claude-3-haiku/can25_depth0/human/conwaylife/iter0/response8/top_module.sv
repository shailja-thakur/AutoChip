module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions to wrap around the grid
function integer wrap(input integer x);
    wrap = (x < 0) ? x + 16 : (x >= 16) ? x - 16 : x;
endfunction

function integer index(input integer row, input integer col);
    index = row * 16 + col;
endfunction

// Combinational logic to compute the next state of a cell
function integer next_state(input integer curr_state, input integer num_neighbors);
    case (num_neighbors)
        0, 1: next_state = 0;
        2: next_state = curr_state;
        3: next_state = 1;
        default: next_state = 0;
    endcase
endfunction

// Registers to store the current state
reg [3:0] neighbors [0:255];

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Compute the number of neighbors for each cell
        for (integer i = 0; i < 256; i = i + 1) begin
            neighbors[i] = 0;
            for (integer j = 0; j < 8; j = j + 1) begin
                neighbors[i] = neighbors[i] + q[index(wrap(i / 16 + j / 3 - 1), wrap(i % 16 + j % 3 - 1))];
            end
        end

        // Update the state of each cell based on the number of neighbors
        for (integer i = 0; i < 256; i = i + 1) begin
            q[i] = next_state(q[i], neighbors[i]);
        end
    end
end

endmodule
