module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

always @(*) begin
    next_state = q;
    for (integer i = 0; i < 256; i++) begin
        integer row = i / 16;
        integer col = i % 16;
        integer neighbors = 0;

        // Wrap-around logic for toroidal grid
        integer row_prev = (row == 0) ? 15 : row - 1;
        integer row_next = (row == 15) ? 0 : row + 1;
        integer col_prev = (col == 0) ? 15 : col - 1;
        integer col_next = (col == 15) ? 0 : col + 1;

        // Count neighbors
        if (q[row_prev * 16 + col_prev]) neighbors++;
        if (q[row_prev * 16 + col]) neighbors++;
        if (q[row_prev * 16 + col_next]) neighbors++;
        if (q[row * 16 + col_prev]) neighbors++;
        if (q[row * 16 + col_next]) neighbors++;
        if (q[row_next * 16 + col_prev]) neighbors++;
        if (q[row_next * 16 + col]) neighbors++;
        if (q[row_next * 16 + col_next]) neighbors++;

        // Apply game rules
        if (q[i]) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_state[i] = 0;
            end
            else begin
                next_state[i] = 1;
            end
        end
        else begin
            if (neighbors == 3) begin
                next_state[i] = 1;
            end
            else begin
                next_state[i] = 0;
            end
        end
    end
end

endmodule
