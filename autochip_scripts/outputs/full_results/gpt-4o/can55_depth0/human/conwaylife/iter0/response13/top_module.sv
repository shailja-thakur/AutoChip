module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;

    // Function to count the number of neighbors that are alive
    function [3:0] count_neighbors;
        input [3:0] row;
        input [3:0] col;
        integer i, j;
        reg [3:0] count;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i !== 0 || j !== 0) begin
                        count = count + q[((row + i + 16) % 16) * 16 + ((col + j + 16) % 16)];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Initial state
    initial begin
        q = 256'b0;
    end

    // Always block to calculate next state
    always @(*) begin
        integer row, col;
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                case (count_neighbors(row, col))
                    4'b0000, 4'b0001: q_next[row * 16 + col] = 1'b0; // 0-1 neighbors -> Cell dies
                    4'b0010: q_next[row * 16 + col] = q[row * 16 + col]; // 2 neighbors -> State remains the same
                    4'b0011: q_next[row * 16 + col] = 1'b1; // 3 neighbors -> Cell becomes alive
                    default: q_next[row * 16 + col] = 1'b0; // 4+ neighbors -> Cell dies
                endcase
            end
        end
    end

    // Always block for synchronous logic
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load initial state
        end else begin
            q <= q_next; // Update to next state
        end
    end

endmodule
