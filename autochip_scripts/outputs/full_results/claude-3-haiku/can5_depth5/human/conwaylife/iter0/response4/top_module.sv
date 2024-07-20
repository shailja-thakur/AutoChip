module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state(q);
    end
end

function [255:0] next_state;
    input [255:0] current_state;
    reg [15:0] row;
    reg [3:0] col, neighbors;
    integer i;
    begin
        for (i = 0; i < 16; i = i + 1) begin
            row = current_state[i*16 +: 16];
            for (col = 0; col < 16; col = col + 1) begin
                neighbors = count_neighbors(current_state, i, col);
                if (row[col] && (neighbors < 2 || neighbors > 3))
                    row[col] = 1'b0;
                else if (!row[col] && neighbors == 3)
                    row[col] = 1'b1;
            end
            next_state[i*16 +: 16] = row;
        end
    end
endfunction

function [3:0] count_neighbors;
    input [255:0] state;
    input [3:0] row, col;
    reg [15:0] left, right, above, below;
    begin
        left = (col == 0) ? state[(row*16) + 15] : state[(row*16) + col - 1];
        right = (col == 15) ? state[(row*16) + 0] : state[(row*16) + col + 1];
        above = (row == 0) ? state[((15*16) + col)] : state[((row-1)*16) + col];
        below = (row == 15) ? state[(col)] : state[((row+1)*16) + col];
        count_neighbors = {left[0], right[0], above[0], below[0]} +
                          {left[1], right[1], above[1], below[1]} +
                          {left[2], right[2], above[2], below[2]} +
                          {left[3], right[3], above[3], below[3]} +
                          {left[4], right[4], above[4], below[4]} +
                          {left[5], right[5], above[5], below[5]} +
                          {left[6], right[6], above[6], below[6]} +
                          {left[7], right[7], above[7], below[7]} +
                          {left[8], right[8], above[8], below[8]} +
                          {left[9], right[9], above[9], below[9]} +
                          {left[10], right[10], above[10], below[10]} +
                          {left[11], right[11], above[11], below[11]} +
                          {left[12], right[12], above[12], below[12]} +
                          {left[13], right[13], above[13], below[13]} +
                          {left[14], right[14], above[14], below[14]} +
                          {left[15], right[15], above[15], below[15]};
    end
endfunction
endmodule
