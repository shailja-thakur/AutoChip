module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100;
        end else begin
            q <= q + 1;
        end
    end
endmodule
