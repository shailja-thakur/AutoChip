module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin

        if (load) 
            q <= data;
        else begin
            q[0] = xnor(q[1], 0);
            for (int i = 1; i < 511; i=i+1) 
                q[i] = xnor(xnor(q[i+1], q[i-1]), 0);
            q[511] = xnor(q[510], 0);
        end

    end

endmodule
