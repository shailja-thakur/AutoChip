module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
    );

    reg [511:0] next_q;

    always @(*) begin
        // Calculate next state of each cell based on Rule 110
        next_q[0] = (0 & q[0] & q[1]) | (0 & q[0] & ~q[1]) | (~q[0] & q[1]);  // Assuming q[-1] is 0
        next_q[511] = (q[510] & q[511] & 0) | (q[510] & ~q[511] & 0) | (~q[510] & q[511]);  // Assuming q[512] is 0

        // Loop through middle cells
        for (int i = 1; i < 511; i = i + 1) begin
            next_q[i] = (q[i-1] & q[i] & q[i+1]) | 
                        (q[i-1] & ~q[i] & q[i+1]) | 
                        (~q[i-1] & q[i]);
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
