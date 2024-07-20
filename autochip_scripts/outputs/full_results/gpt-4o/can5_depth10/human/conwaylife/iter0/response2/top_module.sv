module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    parameter N = 16;
    
    // Function to count the number of live neighbors for a given cell
    function integer count_neighbors;
        input [255:0] state;
        input integer x, y;
        integer i, j, nx, ny, count;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if ((i != 0 || j != 0)) begin
                        nx = (x + i + N) % N;
                        ny = (y + j + N) % N;
                        count = count + state[nx * N + ny];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction
    
    // Process to update state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] next_q;
            integer x, y, neighbors;
            
            for (x = 0; x < N; x = x + 1) begin
                for (y = 0; y < N; y = y + 1) begin
                    neighbors = count_neighbors(q, x, y);
                    case (neighbors)
                        0, 1: next_q[x * N + y] = 0;
                        2: next_q[x * N + y] = q[x * N + y];
                        3: next_q[x * N + y] = 1;
                        default: next_q[x * N + y] = 0;
                    endcase
                end
            end
            
            q <= next_q;
        end
    end
endmodule
