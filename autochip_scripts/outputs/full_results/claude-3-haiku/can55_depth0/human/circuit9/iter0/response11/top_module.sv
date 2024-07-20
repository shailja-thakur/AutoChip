module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        if (q < 3'b111) begin
            q <= q + 3'b001;
        end
    end
    else begin
        if (q > 3'b000) begin
            q <= q - 3'b001;
        end
    end
end

endmodule
