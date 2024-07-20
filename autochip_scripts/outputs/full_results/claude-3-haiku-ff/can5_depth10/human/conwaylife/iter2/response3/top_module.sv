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

always @* begin
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i % 16 != 0) // left
            neighbors += q[i-1];
        else // wrap around
            neighbors += q[i+15];
        if (i % 16 != 15) // right
            neighbors += q[i+1];
        else // wrap around
            neighbors += q[i-15];
        if (i >= 16) // top
            neighbors += q[i-16];
        else // wrap around
            neighbors += q[i+240];
        if (i < 240) // bottom
            neighbors += q[i+16];
        else // wrap around
            neighbors += q[i-240];
        if (q[i]) begin
            if (neighbors == 2 || neighbors == 3)
                next_state[i] = 1'b1;
            else
                next_state[i] = 1'b0;
        end else begin
            if (neighbors == 3)
                next_state[i] = 1'b1;
            else
                next_state[i] = 1'b0;
        end
    end
end

endmodule
