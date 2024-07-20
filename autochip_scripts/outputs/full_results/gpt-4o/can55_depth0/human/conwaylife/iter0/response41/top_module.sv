module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Temporary grid to hold the next state of the game
    reg [255:0] next_q;
    
    // Calculate the number of live neighbors for each cell
    integer i, j;
    function integer count_alive_neighbors;
        input [255:0] state;
        input integer x, y;
        integer count, xi, yi;
        begin
            count = 0;
            for (xi = -1; xi <= 1; xi = xi + 1) begin
                for (yi = -1; yi <= 1; yi = yi + 1) begin
                    if (xi != 0 || yi != 0) begin
                        count = count + state[(((x + xi) & 4'hF) * 16) + ((y + yi) & 4'hF)];
                    end
                end
            end
            count_alive_neighbors = count;
        end
    endfunction

    // Update q based on the current state and count of live neighbors
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_alive_neighbors(q, i, j))
                    2: next_q[(i*16) + j] = q[(i*16) + j];        // Cell maintains its state
                    3: next_q[(i*16) + j] = 1;                    // Cell becomes alive
                    default: next_q[(i*16) + j] = 0;              // Cell becomes dead
                endcase
            end
        end
    end

    // Synchronous load or update grid state
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
