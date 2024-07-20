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
        if (i % 16 != 0) begin // left
            neighbors += q[i-1];
        end else begin // wrap around
            neighbors += q[i+15];
        end
        if (i % 16 != 15) begin // right
            neighbors += q[i+1];
        end else begin // wrap around
            neighbors += q[i-15];
        end
        if (i >= 16) begin // top
            neighbors += q[i-16];
        end else begin // wrap around
            neighbors += q[i+240];
        end
        if (i < 240) begin // bottom
            neighbors += q[i+16];
        end else begin // wrap around
            neighbors += q[i-240];
        end
        if (q[i] && (neighbors == 2 || neighbors == 3)) begin
            next_state[i] = 1'b1;
        end else if (!q[i] && neighbors == 3) begin
            next_state[i] = 1'b1;
        end else begin
            next_state[i] = 1'b0;
        end
    end
end

endmodule
