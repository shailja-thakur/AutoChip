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
    end else begin
        q <= next_state;
    end
end

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int neighbours = 0;
        // Calculate the number of neighbors for each cell
        if (i > 0) begin
            neighbours += q[i-1];
        end
        if (i < 255) begin
            neighbours += q[i+1];
        end
        if (i >= 16) begin
            neighbours += q[i-16];
        end
        if (i < 240) begin
            neighbours += q[i+16];
        end
        if (i > 0 && i >= 16) begin
            neighbours += q[i-17];
        end
        if (i > 0 && i < 240) begin
            neighbours += q[i+15];
        end
        if (i < 255 && i >= 16) begin
            neighbours += q[i-15];
        end
        if (i < 255 && i < 240) begin
            neighbours += q[i+17];
        end
        // Update the state of the cell based on the rules
        if (q[i] == 1'b0 && (neighbours == 2 || neighbours == 3)) begin
            next_state[i] = 1'b1;
        end else if (q[i] == 1'b1 && (neighbours < 2 || neighbours > 3)) begin
            next_state[i] = 1'b0;
        end else begin
            next_state[i] = q[i];
        end
    end
end

endmodule
