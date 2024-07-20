module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    integer i;
    reg [511:0] new_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            new_q[0] = 0 ^ q[1] & q[0];
            new_q[511] = q[510] & ~q[511];
            for(i=1; i<511; i=i+1) begin
                // Calculate the new state based on the rule table
                new_q[i] = (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & q[i] & ~q[i+1]);
            end
            q <= new_q;
        end
    end

endmodule
