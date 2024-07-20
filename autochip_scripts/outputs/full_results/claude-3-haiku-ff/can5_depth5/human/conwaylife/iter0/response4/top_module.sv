module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions to handle the toroidal grid
function int get_neighbor_count(input [255:0] q, input integer row, input integer col);
    integer count;
    integer r, c;
    count = 0;
    for (r = row - 1; r <= row + 1; r = r + 1) begin
        for (c = col - 1; c <= col + 1; c = c + 1) begin
            if (!(r == row && c == col)) begin
                count = count + q[((r + 16) % 16) * 16 + ((c + 16) % 16)];
            end
        end
    end
    return count;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (integer i = 0; i < 256; i = i + 1) begin
            integer row, col;
            row = i / 16;
            col = i % 16;
            integer neighbor_count = get_neighbor_count(q, row, col);
            if (q[i] == 1'b1) begin
                if (neighbor_count < 2 || neighbor_count > 3) begin
                    q[i] <= 1'b0;
                end
                else begin
                    q[i] <= 1'b1;
                end
            end
            else begin
                if (neighbor_count == 3) begin
                    q[i] <= 1'b1;
                end
                else begin
                    q[i] <= 1'b0;
                end
            end
        end
    end
end

endmodule
