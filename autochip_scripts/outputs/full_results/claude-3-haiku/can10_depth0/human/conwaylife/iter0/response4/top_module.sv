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
    reg [7:0] count;
    integer i, j;
begin
    for (i = 0; i < 16; i = i + 1) begin
        row = current_state[(i+1)*16-1:i*16];
        for (j = 0; j < 16; j = j + 1) begin
            count = 0;
            // Check neighbors
            if (j > 0) count = count + row[j-1];
            if (j < 15) count = count + row[j+1];
            if (i > 0) count = count + current_state[((i)*16+j+1)-1];
            if (i < 15) count = count + current_state[((i+2)*16+j)-1];
            if (i > 0 && j > 0) count = count + current_state[((i)*16+j)-1];
            if (i > 0 && j < 15) count = count + current_state[((i)*16+j+2)-1];
            if (i < 15 && j > 0) count = count + current_state[((i+2)*16+j-1)-1];
            if (i < 15 && j < 15) count = count + current_state[((i+2)*16+j+1)-1];
            // Update cell state
            if (row[j] == 1'b1) begin
                if (count < 2 || count > 3) row[j] = 1'b0;
            end
            else begin
                if (count == 3) row[j] = 1'b1;
            end
        end
        next_state[(i+1)*16-1:i*16] = row;
    end
end
endfunction

endmodule
