module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int count = 0;

        // Count the number of alive neighbors
        if (x > 0)              count += q[i-1];
        if (x < 15)            count += q[i+1];
        if (y > 0)              count += q[i-16];
        if (y < 15)            count += q[i+16];
        if (x > 0 && y > 0)     count += q[i-17];
        if (x < 15 && y > 0)   count += q[i-15];
        if (x > 0 && y < 15)    count += q[i+15];
        if (x < 15 && y < 15)  count += q[i+17];

        // Update the state based on the number of neighbors
        if (q[i] == 1'b1) begin
            if (count < 2 || count > 3) begin
                next_q[i] = 1'b0;
            end else begin
                next_q[i] = 1'b1;
            end
        end else begin
            if (count == 3) begin
                next_q[i] = 1'b1;
            end else begin
                next_q[i] = 1'b0;
            end
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
