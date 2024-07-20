module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // extend the boundaries
            q[512] = 0;
            q[-1] = 0;
            
            // compute the next state of each cell
            for (int i = 0; i < 512; i++) begin
                if (i == 0)
                    q[i] = (q[i+1] ^ q[-1]);
                else if (i == 511)
                    q[i] = (q[i-1] ^ q[512]);
                else
                    q[i] = (q[i-1] ^ q[i+1]);
            end
        end
    end
endmodule
