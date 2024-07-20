module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;
    end
    else begin
        if (q == 4'b1001) begin // check if the count has reached 9
            q <= 4'b0000; // reset the count to 0
        end
        else begin
            q <= q + 1'b1; // increment the count
        end
    end
end

endmodule
