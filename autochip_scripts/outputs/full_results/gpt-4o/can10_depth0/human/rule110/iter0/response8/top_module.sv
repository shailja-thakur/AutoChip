module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        // Calculate the next state for the entire array
        next_q[0] = (q[1:0] == 2'b10) || (q[1:0] == 2'b11);               // Treat q[-1] as 0
        next_q[511] = (q[510] && !q[509]) || (q[510] && q[509]);           // Treat q[512] as 0

        integer i;
        for (i = 1; i < 511; i = i + 1) begin
            next_q[i] = ((q[i + 1] && !q[i]) || (q[i + 1] && q[i]) || (q[i] && !q[i - 1]));
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
