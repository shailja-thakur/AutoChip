module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q = q;
            for (integer i = 0; i < 256; i = i + 1) begin
                integer num_neighbors = q[(i+1)%256] + q[(i-1)%256] + q[(i+16)%256] + q[(i-16)%256] + q[(i+15)%256] + q[(i-15)%256] + q[(i+17)%256] + q[(i-17)%256];
                if (num_neighbors == 3) begin
                    next_q[i] <= 1;
                end else if (num_neighbors < 2 || num_neighbors >= 4) begin
                    next_q[i] <= 0;
                end
            end
            q <= next_q;
        end
    end
endmodule
