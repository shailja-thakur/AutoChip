module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    // Calculate the next state of the game
    for (int i = 0; i < 256; i++) begin
        // Calculate the number of neighbors for the current cell
        int neighbors = 0;
        if (i % 16 > 0)             neighbors += q[i - 1];
        if (i % 16 < 15)            neighbors += q[i + 1];
        if (i >= 16)                neighbors += q[i - 16];
        if (i < 240)                neighbors += q[i + 16];
        if (i % 16 > 0 && i >= 16)   neighbors += q[i - 17];
        if (i % 16 < 15 && i >= 16)  neighbors += q[i - 15];
        if (i % 16 > 0 && i < 240)   neighbors += q[i + 15];
        if (i % 16 < 15 && i < 240)  neighbors += q[i + 17];

        // Update the next state based on the number of neighbors
        if (q[i] == 1'b0 && neighbors == 3) begin
            next_q[i] = 1'b1;
        end else if (q[i] == 1'b1 && (neighbors < 2 || neighbors > 3)) begin
            next_q[i] = 1'b0;
        end else begin
            next_q[i] = q[i];
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
end

endmodule
