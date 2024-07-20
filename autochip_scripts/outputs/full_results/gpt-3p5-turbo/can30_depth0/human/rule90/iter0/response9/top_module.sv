module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    always @* begin
        for (int i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                q_next[i] = (q[i+1] ^ q[511] ^ q[0]);
            end else if (i == 511) begin
                q_next[i] = (q[0] ^ q[i-1] ^ q[i]);
            end else begin
                q_next[i] = (q[i+1] ^ q[i-1] ^ q[i]);
            end
        end
    end

endmodule
