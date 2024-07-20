module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            next_q[0] = (q[1] & q[511]) ^ 1'b1;
            next_q[511] = (q[510] & q[0]) ^ 1'b1;
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i-1] & q[i+1]) ^ 1'b1;
            end
            q <= next_q;
        end
    end

    // Initialize q to zero
    initial begin
        q = 0;
    end

endmodule
