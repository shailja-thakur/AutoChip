module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q[0] <= (data[0] & ~data[1]) | (~q[0] & data[1]);
        q[511] <= 1'b0;
        for (int i = 1; i < 511; i++) begin
            q[i] <= (q[i-1] & ~data[i]) | (q[i] & data[i]) | (data[i+1] & ~q[i]);
        end
    end
end

endmodule
