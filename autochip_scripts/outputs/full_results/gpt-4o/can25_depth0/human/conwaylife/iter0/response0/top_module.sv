module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [255:0] next_state;
    integer i, j;

    // Function to count the number of alive neighbours
    function integer count_alive_neighbors;
        input integer x, y;
        integer count, nx, ny;
        integer dx, dy;
        begin
            count = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (dx != 0 || dy != 0) begin
                        nx = (x + dx + 16) % 16;
                        ny = (y + dy + 16) % 16;
                        count = count + q[nx*16 + ny];
                    end
                end
            end
            count_alive_neighbors = count;
        end
    endfunction

    // Compute next state based on current q
    generate
    genvar x, y;
    for (x = 0; x < 16; x = x + 1) begin : row
        for (y = 0; y < 16; y = y + 1) begin : col
            always @(*) begin
                case (count_alive_neighbors(x, y))
                    0, 1: next_state[x*16 + y] = 0;
                    2: next_state[x*16 + y] = q[x*16 + y];
                    3: next_state[x*16 + y] = 1;
                    default: next_state[x*16 + y] = 0;
                endcase
            end
        end
    end
    endgenerate

    // Update q either from data or from next_state
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_state;
    end
endmodule
