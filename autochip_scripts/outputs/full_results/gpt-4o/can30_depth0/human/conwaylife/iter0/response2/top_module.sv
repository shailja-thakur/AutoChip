module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] temp_q;
    integer i, j;

    function integer wrap_index;
        input integer idx;
        begin
            wrap_index = (idx < 0) ? idx + 16 : (idx >= 16) ? idx - 16 : idx;
        end
    endfunction

    function [3:0] count_neighbours;
        input [15:0] row;
        input integer i, j;
        integer m, n;
        begin
            count_neighbours = 0;
            for (m = -1; m <= 1; m = m + 1) begin
                for (n = -1; n <= 1; n = n + 1) begin
                    if (!(m == 0 && n == 0)) begin
                        count_neighbours = count_neighbours + row[wrap_index(i + m) * 16 + wrap_index(j + n)];
                    end
                end
            end
        end
    endfunction

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(q, i, j))
                        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000: temp_q[i * 16 + j] <= 0;
                        4'b0010: temp_q[i * 16 + j] <= q[i * 16 + j];
                        4'b0011: temp_q[i * 16 + j] <= 1;
                        default: temp_q[i * 16 + j] <= 0;
                    endcase
                end
            end
            q <= temp_q;
        end
    end
endmodule
