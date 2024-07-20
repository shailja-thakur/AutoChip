module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    integer i;
    
    // Load data on rising edge of load signal
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Update game state one time step per clock cycle
            q <= next_state(q);
        end
    end
    
    // Function to calculate the next state of the game
    function [255:0] next_state;
        input [255:0] curr_state;
        reg [15:0] row;
        reg [7:0] neighbors;
        integer i, j;
        begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    row = curr_state[(i*16)+:16];
                    neighbors = count_neighbors(row, j);
                    if (row[j] == 1'b1) begin
                        // Any live cell with 0 or 1 live neighbors becomes dead
                        // Any live cell with 4 or more live neighbors becomes dead
                        if ((neighbors < 2) || (neighbors > 3)) begin
                            row[j] = 1'b0;
                        end
                    end
                    else begin
                        // Any dead cell with exactly 3 live neighbors becomes alive
                        if (neighbors == 3) begin
                            row[j] = 1'b1;
                        end
                    end
                    next_state[(i*16)+:16] = row;
                end
            end
        end
    endfunction
    
    // Function to count the number of live neighbors for a given cell
    function [7:0] count_neighbors;
        input [15:0] row;
        input [3:0] col;
        reg [7:0] count;
        begin
            count = 0;
            // Check the 8 neighboring cells
            if (col > 0) begin
                if (row[col-1] == 1'b1) count = count + 1;
            end
            else begin
                if (row[15] == 1'b1) count = count + 1;
            end
            if (col < 15) begin
                if (row[col+1] == 1'b1) count = count + 1;
            end
            else begin
                if (row[0] == 1'b1) count = count + 1;
            end
            if (row[col] == 1'b1) count = count - 1;
            if (col > 0 && col < 15) begin
                if (row[col-1] == 1'b1) count = count + 1;
                if (row[col+1] == 1'b1) count = count + 1;
            end
            else if (col == 0) begin
                if (row[15] == 1'b1) count = count + 1;
                if (row[1] == 1'b1) count = count + 1;
            end
            else begin
                if (row[14] == 1'b1) count = count + 1;
                if (row[0] == 1'b1) count = count + 1;
            end
            count_neighbors = count;
        end
    endfunction
endmodule
