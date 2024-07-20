module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_next;

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            q_next[0] = (q[1] && q[0]) ? 0 : (q[1] || q[0]) ? 1 : 0;
            q_next[1] = (q[2] && q[1]) ? 0 : (q[2] || q[1]) ? 1 : 0;
            q_next[511] = (q[510] && q[511]) ? 0 : (q[510] || q[511]) ? 1 : 0;
            q_next[510] = (q[509] && q[510]) ? 0 : (q[509] || q[510]) ? 1 : 0;

            for (int i = 2; i < 510; i = i + 1) begin
                q_next[i] = (q[i-1] && q[i] && q[i+1]) ? 0 :
                            (q[i-1] && q[i] && !q[i+1]) ? 1 :
                            (q[i-1] && !q[i] && q[i+1]) ? 1 :
                            (q[i-1] && !q[i] && !q[i+1]) ? 0 :
                            (!q[i-1] && q[i] && q[i+1]) ? 1 :
                            (!q[i-1] && q[i] && !q[i+1]) ? 1 :
                            (!q[i-1] && !q[i] && q[i+1]) ? 1 :
                            (!q[i-1] && !q[i] && !q[i+1]) ? 0 : 0;
            end

            q <= q_next;
        end
    end

endmodule
