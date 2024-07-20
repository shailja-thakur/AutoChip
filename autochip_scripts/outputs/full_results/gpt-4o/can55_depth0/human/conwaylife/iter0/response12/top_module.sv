module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    integer i, j;
    
    // Function to compute the number of live neighbours for cell (i, j)
    function automatic [3:0] count_neighbours(input [255:0] q, input integer i, input integer j);
        integer x, y;
        reg [3:0] count;
        begin
            count = 0;
            for (x = -1; x <= 1; x = x + 1) begin
                for (y = -1; y <= 1; y = y + 1) begin
                    if (x != 0 || y != 0) begin
                        // Wrap around using modular arithmetic
                        count = count + q[((i + x + 16) % 16) * 16 + ((j + y + 16) % 16)];
                    end
                end
            end
            count_neighbours = count;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] next_q;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(q, i, j))
                        4'b0000,
                        4'b0001: next_q[i * 16 + j] = 0;   // 0-1 neighbour: Cell becomes 0
                        4'b0010: next_q[i * 16 + j] = q[i * 16 + j]; // 2 neighbours: Cell state does not change
                        4'b0011: next_q[i * 16 + j] = 1;   // 3 neighbours: Cell becomes 1
                        default: next_q[i * 16 + j] = 0;   // 4+ neighbours: Cell becomes 0
                    endcase
                end
            end
            q <= next_q;
        end
    end
endmodule
