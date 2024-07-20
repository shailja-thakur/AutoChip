module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            reg [511:0] next_q;
            for (i = 0; i <= 511; i = i + 1) begin
                if (i == 0) begin
                    // Left boundary, q[-1] is 0
                    next_q[i] = 0 ^ q[i+1];
                end else if (i == 511) begin
                    // Right boundary, q[512] is 0
                    next_q[i] = q[i-1] ^ 0;
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_q;
        end
    end
endmodule
