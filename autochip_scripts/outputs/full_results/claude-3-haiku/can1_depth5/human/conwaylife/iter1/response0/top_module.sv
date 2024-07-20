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
    for (int i = 0; i < 256; i++) begin
        int row = i / 16;
        int col = i % 16;
        int neighbours = 0;
        
        // Calculate the number of neighbours for the current cell
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx != 0 || dy != 0) begin
                    int nx = (col + dx + 16) % 16;
                    int ny = (row + dy + 16) % 16;
                    neighbours += q[ny * 16 + nx];
                end
            end
        end
        
        // Update the next state of the current cell based on the number of neighbours
        if (q[i] == 1'b1) begin
            if (neighbours < 2 || neighbours > 3) begin
                next_state[i] = 1'b0;
            end
            else begin
                next_state[i] = 1'b1;
            end
        end
        else begin
            if (neighbours == 3) begin
                next_state[i] = 1'b1;
            end
            else begin
                next_state[i] = 1'b0;
            end
        end
    end
end

endmodule
