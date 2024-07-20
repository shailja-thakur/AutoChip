module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Shift q to the right and add 0 at the beginning
            q <= {1'b0, q[511:1]};
        end
    end

endmodule
