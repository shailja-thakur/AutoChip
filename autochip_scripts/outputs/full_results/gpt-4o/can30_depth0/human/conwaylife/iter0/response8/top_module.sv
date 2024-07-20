module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [4:0] neighbour_count [255:0]; // Array to store the count of neighbours for each cell

    integer i, j, ni, nj;
    
    // Function to calculate neighbor index in a wrap-around fashion
    function [7:0] wrap_index;
        input integer m;
        input integer n;
        wrap_index = ((m % 16) + 16) % 16 + 16 * (((n % 16) + 16) % 16);
    endfunction

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbour_count[wrap_index(i,j)] = 0;
                for (ni = -1; ni <= 1; ni = ni + 1) begin
                    for (nj = -1; nj <= 1; nj = nj + 1) begin
                        if (!(ni == 0 && nj == 0)) begin
                            neighbour_count[wrap_index(i, j)] = neighbour_count[wrap_index(i, j)] +
                                                               q[wrap_index(i + ni, j + nj)];
                        end
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load initial state
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (neighbour_count[wrap_index(i, j)])
                        0, 1: q[wrap_index(i, j)] <= 0;
                        2: q[wrap_index(i, j)] <= q[wrap_index(i, j)];  // No change
                        3: q[wrap_index(i, j)] <= 1;
                        default: q[wrap_index(i, j)] <= 0;
                    endcase
                end
            end
        end
    end
endmodule
