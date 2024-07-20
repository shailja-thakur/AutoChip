module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = q;
    for (integer i = 0; i < 256; i++) begin
        integer x = i % 16;
        integer y = i / 16;
        integer neighbours = 0;

        // Wrap around the edges
        integer xm1 = (x == 0) ? 15 : x - 1;
        integer xp1 = (x == 15) ? 0 : x + 1;
        integer ym1 = (y == 0) ? 15 : y - 1;
        integer yp1 = (y == 15) ? 0 : y + 1;

        // Count the number of neighbours
        if (q[xm1 + 16*ym1]) neighbours++;
        if (q[x + 16*ym1]) neighbours++;
        if (q[xp1 + 16*ym1]) neighbours++;
        if (q[xm1 + 16*y]) neighbours++;
        if (q[xp1 + 16*y]) neighbours++;
        if (q[xm1 + 16*yp1]) neighbours++;
        if (q[x + 16*yp1]) neighbours++;
        if (q[xp1 + 16*yp1]) neighbours++;

        // Update the next state based on the number of neighbours
        if (q[i]) begin
            if (neighbours < 2 || neighbours > 3) begin
                next_q[i] = 0;
            end
            else begin
                next_q[i] = 1;
            end
        end
        else begin
            if (neighbours == 3) begin
                next_q[i] = 1;
            end
        end
    end
end

endmodule
