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
    assign row_nbrs[0] = {q[15], q[0]};
    assign row_nbrs[1] = {q[15:1]};
    assign row_nbrs[2] = {q[14:0], q[15]};
    assign row_nbrs[3] = {q[13:0], q[15:14]};
    assign row_nbrs[4] = {q[12:0], q[15:13]};
    assign row_nbrs[5] = {q[11:0], q[15:12]};
    assign row_nbrs[6] = {q[10:0], q[15:11]};
    assign row_nbrs[7] = {q[9:0], q[15:10]};

    // Generate column neighbors
    assign col_nbrs[0] = {q[0], q[240], q[15]};
    assign col_nbrs[1] = {q[1:0], q[241], q[16]};
    assign col_nbrs[2] = {q[2:0], q[242], q[17]};
    assign col_nbrs[3] = {q[3:0], q[243], q[18]};
    assign col_nbrs[4] = {q[4:0], q[244], q[19]};
    assign col_nbrs[5] = {q[5:0], q[245], q[20]};
    assign col_nbrs[6] = {q[6:0], q[246], q[21]};
    assign col_nbrs[7] = {q[7:0], q[247], q[22]};
    
    // Generate next state based on number of neighbors
    always @(*)
    begin
        neighbors = 0;

        for(int i=0; i < 8; i=i+1)
        begin
            if(row_nbrs[i] == 1)
                neighbors = neighbors + 1;
        end

        for(int i=0; i < 8; i=i+1)
        begin
            if(col_nbrs[i] == 1)
                neighbors = neighbors + 1;
        end

        if(neighbors <= 1)
            next_q = 0;
        else if(neighbors == 2)
            next_q = q;
        else if(neighbors == 3)
            next_q = 1;
        else
            next_q = 0;
    end

    // Synchronous load
    always @(posedge clk)
    begin
        if(load == 1)
            q <= data;
        else
            q <= next_q;
    end

endmodule
