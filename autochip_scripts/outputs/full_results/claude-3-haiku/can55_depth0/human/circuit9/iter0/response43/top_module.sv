module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 3'd4)
            q <= 3'd5;
        else if (q == 3'd5)
            q <= 3'd6;
        else
            q <= q + 1'b1;
    end
    else
        q <= 3'd0;
end

endmodule
