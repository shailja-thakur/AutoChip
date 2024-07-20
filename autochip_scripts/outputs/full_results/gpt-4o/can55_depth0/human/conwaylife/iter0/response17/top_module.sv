module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    integer i, j;
    
    // Function to count the number of alive neighbors
    function integer count_neighbors;
        input [15:0] row;
        input [15:0] col;
        input [255:0] grid;
        integer r, c;
        integer count;
    begin
        count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (r !== 0 || c !== 0) begin
                    // Wrap around rows and columns to create toroid behavior
                    count = count + grid[(((row + r) + 16) % 16) * 16 + ((col + c) + 16) % 16];
                end
            end
        end
        count_neighbors = count;
    end
    endfunction

    // Updates the next state of the grid
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer neighbors = count_neighbors(i, j, q);
                case(neighbors)
                    0, 1: next_q[i * 16 + j] = 0;
                    2: next_q[i * 16 + j] = q[i * 16 + j];
                    3: next_q[i * 16 + j] = 1;
                    default: next_q[i * 16 + j] = 0;
                endcase
            end
        end
    end
    
    // Sequential logic to update the grid on clock edge
    always @(posedge clk) begin
        if (load) 
            q <= data;
        else 
            q <= next_q;
    end
endmodule
