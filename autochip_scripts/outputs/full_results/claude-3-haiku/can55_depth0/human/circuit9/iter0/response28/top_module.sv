module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 3'b100)
            q <= 3'b000;
        else
            q <= q + 1;
    end
    else begin
        q <= q;
    end
end

endmodule
