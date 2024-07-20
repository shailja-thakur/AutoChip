module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] q_int;

    always @(posedge clk) begin
        if (load) begin
            q_int <= data;
        end else begin
            q_int[0] <= 0;
            for (int i=1; i<511; i=i+1) begin
                q_int[i] <= ((q[i+1] & (q[i] | ~q[i-1])) | (~q[i+1] & (~q[i-1] | q[i])));
            end
            q_int[511] <= ((q[510] & q[511] & ~q[0]) | (~q[510] & ~q[511] & q[0]));
        end
    end

    always @(posedge clk) begin
        q <= q_int;
    end

endmodule
