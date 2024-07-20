module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] num_neighbors[15:0][15:0];
    integer x, y, i, j;

    always @(*) begin
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                num_neighbors[x][y] = 4'd0;
                for (i = -1; i <= 1; i = i + 1) begin
                    for (j = -1; j <= 1; j = j + 1) begin
                        if (i != 0 || j != 0) begin
                            num_neighbors[x][y] = num_neighbors[x][y] + q[((x+i+16)%16)*16 + (y+j+16)%16];
                        end
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    case (num_neighbors[x][y])
                        4'd2: q[x*16 + y] <= q[x*16 + y]; // state does not change
                        4'd3: q[x*16 + y] <= 1'b1;        // becomes alive
                        default: q[x*16 + y] <= 1'b0;     // becomes dead
                    endcase
                end
            end
        end
    end
endmodule
