module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] neighbours [255:0];

    integer i, j;

    // Calculate the number of neighbours for every cell
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer index = i * 16 + j;
                neighbours[index] = 0;
                neighbours[index] = q[((i + 15) % 16) * 16 + ((j + 15) % 16)] + q[((i + 15) % 16) * 16 + j] + q[((i + 15) % 16) * 16 + ((j + 1) % 16)];
                neighbours[index] = neighbours[index] + q[(i * 16) + ((j + 15) % 16)] + q[(i * 16) + ((j + 1) % 16)];
                neighbours[index] = neighbours[index] + q[((i + 1) % 16) * 16 + ((j + 15) % 16)] + q[((i + 1) % 16) * 16 + j] + q[((i + 1) % 16) * 16 + ((j + 1) % 16)];
            end
        end
    end

    // Updating the game state at each clock cycle
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer index = i * 16 + j;
                    if (neighbours[index] == 2)
                        q[index] <= q[index];
                    else if (neighbours[index] == 3)
                        q[index] <= 1;
                    else
                        q[index] <= 0;
                end
            end
        end
    end
endmodule
