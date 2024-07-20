module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Internal signal to store the next state of the grid
    reg [255:0] next_q;
    
    // Function to count the number of alive neighbours for a given cell
    function integer count_neighbours;
        input [3:0] row;
        input [3:0] col;
        integer count;
        begin
            count = 0;
            integer r, c;
            // Iterate through the possible neighbours, using wrap-around for toroidal grid
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin // Skip the cell itself
                        if (q[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)] == 1)
                            count = count + 1;
                    end
                end
            end
            count_neighbours = count;
        end
    endfunction
    
    // Update logic for the grid
    always @(*) begin
        integer i, j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer count;
                count = count_neighbours(i, j);
                if (count < 2 || count > 3)
                    next_q[i * 16 + j] = 0;
                else if (count == 3)
                    next_q[i * 16 + j] = 1;
                else
                    next_q[i * 16 + j] = q[i * 16 + j];
            end
        end
    end
    
    // Synchronous update
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
