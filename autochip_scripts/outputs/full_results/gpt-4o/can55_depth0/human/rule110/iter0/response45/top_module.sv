module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    
    always @(*) begin
        next_q[511] = (q[510] & q[511] & 0) | (q[510] & q[511] & 1) | (q[510] & 0 & 1) | (0 & q[511] & 1);  // Boundary condition
        next_q[0]   = (q[1] & q[0] & 0) | (q[1] & q[0] & 1) | (q[1] & 0 & 1) | (0 & q[0] & 1);              // Boundary condition
        
        for (int i = 1; i < 511; i = i + 1) begin
            next_q[i] = (q[i + 1] & q[i] & q[i - 1]) ? 0 :
                        (q[i + 1] & q[i] & ~q[i - 1]) ? 1 :
                        (q[i + 1] & ~q[i] & q[i - 1]) ? 1 :
                        (q[i + 1] & ~q[i] & ~q[i - 1]) ? 0 :
                        (~q[i + 1] & q[i] & q[i - 1]) ? 1 :
                        (~q[i + 1] & q[i] & ~q[i - 1]) ? 1 :
                        (~q[i + 1] & ~q[i] & q[i - 1]) ? 1 : 0;
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
