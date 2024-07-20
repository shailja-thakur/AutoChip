module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] count [255:0];  // 4-bit neighbor count for each cell
    integer i, j, x, y;

    // Function to get the value of a cell wrapped around the toroid
    function [0:0] get_cell;
        input integer row;
        input integer col;
        begin
            get_cell = q[((row & 4'hf) * 16) + (col & 4'hf)];
        end
    endfunction
    
    always @(*) begin
        // Count the neighbors for each cell
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                count[(i * 16) + j] = 0;
                for (x = -1; x <= 1; x = x + 1) begin
                    for (y = -1; y <= 1; y = y + 1) begin
                        if ((x != 0) || (y != 0)) begin
                            count[(i * 16) + j] = count[(i * 16) + j] + get_cell(i + x, j + y);
                        end
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 256; i = i + 1) begin
                if (count[i] < 2) begin
                    q[i] <= 0;
                end else if (count[i] == 2) begin
                    q[i] <= q[i];
                end else if (count[i] == 3) begin
                    q[i] <= 1;
                end else begin
                    q[i] <= 0;
                end
            end
        end
    end
endmodule
