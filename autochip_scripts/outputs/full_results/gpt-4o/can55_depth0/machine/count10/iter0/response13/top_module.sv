module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end
        else if (q == 4'b1001) begin // If q is 9
            q <= 0;
        end
        else begin
            q <= q + 1;
        end
    end

endmodule
