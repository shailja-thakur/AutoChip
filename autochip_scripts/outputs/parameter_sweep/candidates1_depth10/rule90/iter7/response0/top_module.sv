module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] tmp_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        tmp_q[0] <= (q[1] & q[0]) ^ (~q[1] & q[0]);
        
        for (int i = 1; i <= 510; i = i + 1) begin
            tmp_q[i] <= (q[i-1] & q[i]) ^ (~q[i-1] & q[i+1]);
        end
        
        tmp_q[511] <= (q[510] & q[511]) ^ (~q[510] & q[511]);
        
        q <= tmp_q; // Move this assignment inside the else block
    end
end

endmodule
