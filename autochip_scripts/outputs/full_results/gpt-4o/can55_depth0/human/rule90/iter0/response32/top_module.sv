module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // Create a new array to store the next state
            reg [511:0] next_q;
            integer i;
            next_q[0] = q[1]; // Boundary condition (q[-1] is 0)
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            next_q[511] = q[510]; // Boundary condition (q[512] is 0)
            q <= next_q;
        end
    end

endmodule
