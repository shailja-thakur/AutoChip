module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'b100;
    end else if (a == 0 && q == 3'b110) begin
        q <= 3'b000;
    end else if (a == 0 && q != 3'b110) begin
        q <= q + 1;
    end
end

endmodule
