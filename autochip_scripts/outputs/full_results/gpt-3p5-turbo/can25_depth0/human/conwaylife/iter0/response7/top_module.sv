module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    reg [255:0] next_q;

    always @(posedge clk)
    begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

    integer i;
    integer j;
    always @*
    begin
        for (j = 0; j < 256; j = j + 16)
        begin
            for (i = 0; i < 16; i = i + 1)
            begin
                integer row_above;
                integer row_below;
                integer col_left;
                integer col_right;
                
                if (i == 0)
                    col_left = j + 15;
                else
                    col_left = j + i - 1;
                
                if (i == 15)
                    col_right = j;
                else
                    col_right = j + i + 1;
                
                if (j == 0)
                    row_above = j + 240;
                else
                    row_above = j - 16;
                
                if (j == 240)
                    row_below = j;
                else
                    row_below = j + 16;
                

                integer num_neighbors = q[col_left] + q[col_right] + q[row_above+i] + q[row_below+i] + q[row_below+col_left] + q[row_below+col_right] + q[row_above+col_left] + q[row_above+col_right];

                if (q[j+i] == 1)
                begin
                    // Cell is alive
                    if (num_neighbors < 2 || num_neighbors >= 4)
                        next_q[j+i] = 0;
                    else
                        next_q[j+i] = 1;
                end
                else
                begin
                    // Cell is dead
                    if (num_neighbors == 3)
                        next_q[j+i] = 1;
                    else
                        next_q[j+i] = 0;
                end
            end
        end
    end

endmodule
