module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i % 16 != 0)        neighbors += q[i-1];
        else                    neighbors += q[i+15];
        if (i % 16 != 15)       neighbors += q[i+1];
        else                    neighbors += q[i-15];
        if (i >= 16)            neighbors += q[i-16];
        if (i < 240)            neighbors += q[i+16];
        
        if (q[i] & (neighbors == 2 || neighbors == 3)) begin
            next_q[i] = 1'b1;
        end
        else if (~q[i] & neighbors == 3) begin
            next_q[i] = 1'b1;
        end
        else begin
            next_q[i] = 1'b0;
        end
    end
end

endmodule
