module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // Right shift q and insert 0 at the MSB
            q <= {1'b0, q[511:1]};
        end
    end
endmodule
