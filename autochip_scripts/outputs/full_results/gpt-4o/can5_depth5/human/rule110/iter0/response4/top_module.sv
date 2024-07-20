module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Boundary conditions
                if (i == 0)
                    next_q[i] = (1'b0 & q[i] & q[i+1]) | (1'b1 & q[i] & ~q[i+1]) | (1'b1 & ~q[i] & q[i+1]);
                else if (i == 511)
                    next_q[i] = (q[i-1] & q[i] & 1'b0) | (q[i-1] & q[i] & 1'b1) | (~q[i-1] & q[i] & 1'b0) | (~q[i-1] & q[i] & 1'b1);
                else
                    next_q[i] = (q[i-1] & q[i] & q[i+1]) ? 1'b0 : 
                                (q[i-1] & q[i] & ~q[i+1]) ? 1'b1 :
                                (q[i-1] & ~q[i] & q[i+1]) ? 1'b1 :
                                (q[i-1] & ~q[i] & ~q[i+1]) ? 1'b0 :
                                (~q[i-1] & q[i] & q[i+1]) ? 1'b1 :
                                (~q[i-1] & q[i] & ~q[i+1]) ? 1'b1 :
                                (~q[i-1] & ~q[i] & q[i+1]) ? 1'b1 : 1'b0;
            end
            q <= next_q;
        end
    end
endmodule
