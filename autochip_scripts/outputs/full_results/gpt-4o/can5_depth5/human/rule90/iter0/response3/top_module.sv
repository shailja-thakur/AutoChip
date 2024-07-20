module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    integer i;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = q[i+1]; // Left neighbor is 0 as q[-1] is off (0)
                end else if (i == 511) begin
                    next_q[i] = q[i-1]; // Right neighbor is 0 as q[512] is off (0)
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end
            q <= next_q;
        end
    end
    
endmodule
