module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

// Function to count the alive neighbours of a cell
function [3:0] count_neighbours;
    input integer x, y;
    integer i, j;
    reg [3:0] count;
    begin
        count = 0;
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i != 0 || j != 0) begin
                    if (q[((x + i + 16) % 16) * 16 + (y + j + 16) % 16]) begin
                        count = count + 1;
                    end
                end
            end
        end
        count_neighbours = count;
    end
endfunction

// Local signal to hold next state
reg [255:0] next_q;

integer x, y;
always @(*) begin
    // Compute the next state for all cells
    for (x = 0; x < 16; x = x + 1) begin
        for (y = 0; y < 16; y = y + 1) begin
            case (count_neighbours(x, y))
                4'h2: next_q[x * 16 + y] = q[x * 16 + y]; // Cell stays the same if it has exactly 2 neighbours
                4'h3: next_q[x * 16 + y] = 1; // Cell becomes alive if it has exactly 3 neighbours
                default: next_q[x * 16 + y] = 0; // Cell dies in all other cases
            endcase
        end
    end
end

// Update the state on clock edge or load new data
always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_q;
end

endmodule
