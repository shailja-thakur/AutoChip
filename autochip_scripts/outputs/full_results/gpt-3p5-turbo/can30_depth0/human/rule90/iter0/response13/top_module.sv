module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;

    always @(posedge clk) begin
        if(load)
            q <= data;
        else begin
            q_next[0] = q[1] ^ q[511];
            q_next[1] = q[0] ^ q[2];
            for (int i = 2; i < 510; i = i + 1)
                q_next[i] = q[i - 1] ^ q[i + 1];
            q_next[510] = q[509] ^ q[511];
            q_next[511] = q[510] ^ q[0];
            q <= q_next;
        end
    end

endmodule
