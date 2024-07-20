module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_q; // Next state of each cell

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
    
    // Calculate next state
    for (int i = 0; i < 512; i = i + 1) begin
        if (i == 0) begin
            next_q[i] = (q[i+1] ^ 0);
        end else if (i == 511) begin
            next_q[i] = (0 ^ q[i-1]);
        end else begin
            next_q[i] = (q[i+1] ^ q[i-1]);
        end
    end
end

endmodule
