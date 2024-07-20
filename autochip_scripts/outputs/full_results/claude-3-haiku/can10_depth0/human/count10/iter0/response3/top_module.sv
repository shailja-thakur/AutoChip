module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0;
    else begin
        if (q == 4'd9)
            q <= 4'b0;
        else
            q <= q + 1;
    end
end

endmodule
