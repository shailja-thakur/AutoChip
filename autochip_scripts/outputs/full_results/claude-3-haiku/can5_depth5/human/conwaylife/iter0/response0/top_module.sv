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
    reg [15:0] new_row;
    integer i, j, neighbors;
begin
    for (i = 0; i < 16; i = i + 1) begin
        row = current_state[16*i +: 16];
        new_row = 0;
        for (j = 0; j < 16; j = j + 1) begin
            neighbors = 0;
            if (j > 0) neighbors = neighbors + row[j-1];
            if (j < 15) neighbors = neighbors + row[j+1];
            if (i > 0) neighbors = neighbors + current_state[16*(i-1) + j];
            if (i < 15) neighbors = neighbors + current_state[16*(i+1) + j];
            if (i > 0 && j > 0) neighbors = neighbors + current_state[16*(i-1) + j-1];
            if (i > 0 && j < 15) neighbors = neighbors + current_state[16*(i-1) + j+1];
            if (i < 15 && j > 0) neighbors = neighbors + current_state[16*(i+1) + j-1];
            if (i < 15 && j < 15) neighbors = neighbors + current_state[16*(i+1) + j+1];
            if (row[j] == 1'b1 && (neighbors == 2 || neighbors == 3)) begin
                new_row[j] = 1'b1;
            end
            else if (row[j] == 1'b0 && neighbors == 3) begin
                new_row[j] = 1'b1;
            end
            else begin
                new_row[j] = 1'b0;
            end
        end
        next_state[16*i +: 16] = new_row;
    end
end
endfunction

endmodule
