module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    reg [15:0] neighbors;
    wire [7:0] row_nbrs;
    wire [7:0] col_nbrs;

    // Generate row neighbors
    assign row_nbrs[0] = q[15] ? 1 : 0;
    assign row_nbrs[1] = q[15:0] ? 1 : 0;
    assign row_nbrs[2] = q[15:1] ? 1 : 0;
    assign row_nbrs[3] = q[15:2] ? 1 : 0;
    assign row_nbrs[4] = q[15:3] ? 1 : 0;
    assign row_nbrs[5] = q[15:4] ? 1 : 0;
    assign row_nbrs[6] = q[15:5] ? 1 : 0;
    assign row_nbrs[7] = q[15:6] ? 1 : 0;

    // Generate column neighbors
    assign col_nbrs[0] = {q[0], q[16], q[240]};
    assign col_nbrs[1] = {q[1], q[17], q[241]};
    assign col_nbrs[2] = {q[2], q[18], q[242]};
    assign col_nbrs[3] = {q[3], q[19], q[243]};
    assign col_nbrs[4] = {q[4], q[20], q[244]};
    assign col_nbrs[5] = {q[5], q[21], q[245]};
    assign col_nbrs[6] = {q[6], q[22], q[246]};
    assign col_nbrs[7] = {q[7], q[23], q[247]};

    // Counts the number of alive neighbors for each cell
    always @(*)
    begin
        neighbors = 0;
        for (int i = 0; i < 8; i = i + 1)
        begin
            if (row_nbrs[i] == 1)
            begin
                neighbors = neighbors + 1;
            end
        end
        for (int i = 0; i < 8; i = i + 1)
        begin
            if (col_nbrs[i] == 1)
            begin
                neighbors = neighbors + 1;
            end
        end

        // Determine next state based on number of neighbors
        if (neighbors <= 1)
        begin
            next_q = 0;
        end
        else if (neighbors == 2)
        begin
            next_q = q;
        end
        else if (neighbors == 3)
        begin
            next_q = 1;
        end
        else if (neighbors >= 4)
        begin
            next_q = 0;
        end
        else
        begin
            next_q = 0;
        end
    end

    // Synchronous load
    always @(posedge clk)
    begin
        if (load == 1)
        begin
            q <= data;
        end
        else
        begin
            q <= next_q;
        end
    end

endmodule
