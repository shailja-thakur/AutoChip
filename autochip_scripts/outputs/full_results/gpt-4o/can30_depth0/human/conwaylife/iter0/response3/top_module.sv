module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Function to count alive neighbors
    function integer count_neighbors;
        input [15:0] x, y;
        integer i, j;
        begin
            count_neighbors = 0;
            
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (!(i == 0 && j == 0)) begin
                        count_neighbors = count_neighbors + q[(y+16+i)%16*16 + (x+16+j)%16];
                    end
                end
            end
        end
    endfunction

    // Function to compute next state for a cell
    function next_state;
        input state;
        input integer neighbors;
        begin
            if (neighbors < 2)
                next_state = 0;
            else if (neighbors == 2)
                next_state = state;
            else if (neighbors == 3)
                next_state = 1;
            else
                next_state = 0;
        end
    endfunction

    // Compute next state for the entire grid
    integer x, y;
    always @(*) begin
        for (y = 0; y < 16; y = y + 1) begin
            for (x = 0; x < 16; x = x + 1) begin
                next_q[y*16 + x] = next_state(q[y*16 + x], count_neighbors(x,y));
            end
        end
    end

    // Sequential logic to load data or update state
    always @(posedge clk) begin
        if (load) 
            q <= data;
        else
            q <= next_q;
    end

endmodule
