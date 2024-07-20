module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load == 1'b1) begin
            q <= data;
        end else begin
            q[511] <= (q[510] & q[511] & 1'b1) ? 1'b0 : 1'b1;
            for (int i = 510; i > 0; i = i - 1) begin
                q[i] <= (q[i-1] & q[i] & q[i+1]) ? 1'b0 : 1'b1;
            end
            q[0] <= (q[1] & q[0] & 1'b0) ? 1'b0 : 1'b1;

            // Set boundary values to 0
            q[511] <= 1'b0;
            q[0] <= 1'b0;
        end
    end

endmodule
