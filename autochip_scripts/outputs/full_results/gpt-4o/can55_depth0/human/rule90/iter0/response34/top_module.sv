module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    integer i;
    reg [511:0] next_q;

    always @(*) begin
        next_q[0] = 0 ^ q[1]; // Boundary condition for q[-1] is 0
        next_q[511] = q[510] ^ 0; // Boundary condition for q[512] is 0
        
        for (i = 1; i < 511; i = i + 1) begin
            next_q[i] = q[i-1] ^ q[i+1];
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
