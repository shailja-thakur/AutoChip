module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Parameters for grid dimensions
    parameter WIDTH = 16;
    parameter HEIGHT = 16;

    // Function to calculate the modulo, better for handling negative values
    function integer mod(input integer a, input integer b);
        begin
            mod = (a % b + b) % b;
        end
    endfunction

    // Function to count the number of alive neighbors
    function [3:0] count_neighbors;
        input [255:0] grid;
        input [3:0] x;
        input [3:0] y;
        integer i, j;
        begin
            count_neighbors = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin
                        if (grid[(mod(x+i, WIDTH) + mod(y+j, HEIGHT) * WIDTH)] == 1) begin
                            count_neighbors = count_neighbors + 1;
                        end
                    end
                end
            end
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] new_q;
            integer x, y;
            for (y = 0; y < HEIGHT; y = y + 1) begin
                for (x = 0; x < WIDTH; x = x + 1) begin
                    case (count_neighbors(q, x, y))
                        4'd2: new_q[x + y * WIDTH] = q[x + y * WIDTH]; // Stays the same
                        4'd3: new_q[x + y * WIDTH] = 1; // Becomes alive
                        default: new_q[x + y * WIDTH] = 0; // Becomes dead
                    endcase
                end
            end
            q <= new_q;
        end
    end
    
endmodule
