module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Define the 16x16 toroid
    function [15:0] get_neighbor_count(input [255:0] state, input [7:0] row, input [7:0] col);
        begin
            get_neighbor_count = 0;
            // Check the 8 surrounding cells
            if (row > 0)
                get_neighbor_count = get_neighbor_count + state[(row-1)*16 + col];
            else
                get_neighbor_count = get_neighbor_count + state[(15*16) + col];
            if (row < 15)
                get_neighbor_count = get_neighbor_count + state[(row+1)*16 + col];
            else
                get_neighbor_count = get_neighbor_count + state[col];
            if (col > 0)
                get_neighbor_count = get_neighbor_count + state[row*16 + (col-1)];
            else
                get_neighbor_count = get_neighbor_count + state[row*16 + 15];
            if (col < 15)
                get_neighbor_count = get_neighbor_count + state[row*16 + (col+1)];
            else
                get_neighbor_count = get_neighbor_count + state[row*16];
            if (row > 0 && col > 0)
                get_neighbor_count = get_neighbor_count + state[(row-1)*16 + (col-1)];
            else if (row > 0 && col == 0)
                get_neighbor_count = get_neighbor_count + state[(row-1)*16 + 15];
            else if (row == 0 && col > 0)
                get_neighbor_count = get_neighbor_count + state[(15*16) + (col-1)];
            else
                get_neighbor_count = get_neighbor_count + state[(15*16) + 15];
            if (row < 15 && col < 15)
                get_neighbor_count = get_neighbor_count + state[(row+1)*16 + (col+1)];
            else if (row < 15 && col == 15)
                get_neighbor_count = get_neighbor_count + state[col];
            else if (row == 15 && col < 15)
                get_neighbor_count = get_neighbor_count + state[(col+1)];
            else
                get_neighbor_count = get_neighbor_count + state[0];
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    if (q[i*16 + j]) begin
                        if (get_neighbor_count(q, i, j) < 2 || get_neighbor_count(q, i, j) > 3)
                            q[i*16 + j] <= 1'b0;
                        else
                            q[i*16 + j] <= 1'b1;
                    end
                    else begin
                        if (get_neighbor_count(q, i, j) == 3)
                            q[i*16 + j] <= 1'b1;
                        else
                            q[i*16 + j] <= 1'b0;
                    end
                end
            end
        end
    end

endmodule
