module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

wire [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

// Helper functions
function int get_neighbor_count(input [255:0] state, input integer x, input integer y);
    integer count = 0;
    integer xi, yi;
    for (xi = x - 1; xi <= x + 1; xi = xi + 1) begin
        for (yi = y - 1; yi <= y + 1; yi = yi + 1) begin
            if (xi != x || yi != y) begin
                count = count + ((state[(yi * 16) + (xi % 16)] == 1'b1) ? 1 : 0);
            end
        end
    end
    return count;
endfunction

always @(*) begin
    for (integer i = 0; i < 16; i = i + 1) begin
        for (integer j = 0; j < 16; j = j + 1) begin
            integer neighbor_count = get_neighbor_count(q, j, i);
            if (q[(i * 16) + j] == 1'b1) begin
                next_state[(i * 16) + j] = (neighbor_count == 2 || neighbor_count == 3) ? 1'b1 : 1'b0;
            end
            else begin
                next_state[(i * 16) + j] = (neighbor_count == 3) ? 1'b1 : 1'b0;
            end
        end
    end
end

endmodule
