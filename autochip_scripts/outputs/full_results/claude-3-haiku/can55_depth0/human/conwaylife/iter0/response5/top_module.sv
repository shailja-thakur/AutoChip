module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

// Helper functions to get neighbor counts
function integer get_neighbor_count(input [255:0] state, input integer row, input integer col);
    integer count;
    integer r, c;
    count = 0;
    for (r = row - 1; r <= row + 1; r = r + 1) begin
        for (c = col - 1; c <= col + 1; c = c + 1) begin
            if (r != row || c != col) begin
                if (r < 0) r = r + 16;
                else if (r >= 16) r = r - 16;
                if (c < 0) c = c + 16;
                else if (c >= 16) c = c - 16;
                count = count + ((state >> (r * 16 + c)) & 1);
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
        // Update game state
        for (integer i = 0; i < 256; i = i + 1) begin
            integer row, col, neighbor_count;
            row = i / 16;
            col = i % 16;
            neighbor_count = get_neighbor_count(q, row, col);
            if (neighbor_count < 2 || neighbor_count > 3) begin
                next_state[i] = 0;
            end
            else if (neighbor_count == 2) begin
                next_state[i] = q[i];
            end
            else if (neighbor_count == 3) begin
                next_state[i] = 1;
            end
        end
        q <= next_state;
    end
end

endmodule
