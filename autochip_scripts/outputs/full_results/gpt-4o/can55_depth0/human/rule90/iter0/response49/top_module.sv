module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = q[1] ^ 0;  // q[-1] assumed to be 0, q[1] is the Right neighbor
                end else if (i == 511) begin
                    next_q[i] = q[510] ^ 0; // q[512] assumed to be 0, q[510] is the Left neighbor
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1]; // Regular case for cells between 1 and 510
                end
            end
            q <= next_q;
        end
    end
endmodule
