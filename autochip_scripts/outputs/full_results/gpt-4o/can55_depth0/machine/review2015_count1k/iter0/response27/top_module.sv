module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0;
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0;
            end else begin
                q <= q + 10'b1;
            end
        end
    end

endmodule
