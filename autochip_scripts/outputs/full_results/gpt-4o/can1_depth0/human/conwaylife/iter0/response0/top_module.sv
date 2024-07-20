module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;
    integer row, col;

    function integer get_index;
        input integer row, col;
        begin
            get_index = (row % 16) * 16 + (col % 16);
        end
    endfunction

    function integer count_neighbors;
        input integer row, col;
        integer r, c;
        integer sum;
        begin
            sum = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (!(r == 0 && c == 0)) begin // Do not count the cell itself
                        sum = sum + q[get_index(row + r, col + c)];
                    end
                end
            end
            count_neighbors = sum;
        end
    endfunction

    always @(*) begin
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                integer neighbors;
                neighbors = count_neighbors(row, col);
                case(neighbors)
                    2: q_next[get_index(row, col)] = q[get_index(row, col)];
                    3: q_next[get_index(row, col)] = 1;
                    default: q_next[get_index(row, col)] = 0;
                endcase
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

endmodule
