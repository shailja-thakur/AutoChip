module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always@(posedge clk)
    begin
        if(load)
            q <= data;
        else
        begin
            q[0] = (q[1] & q[511]) ^ q[0];
            for(int i=1; i<511; i=i+1)
                q[i] = (q[i-1] & q[i+1]) ^ q[i];
            q[511] = (q[510] & q[0]) ^ q[511];
        end
    end

endmodule
