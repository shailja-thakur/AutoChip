module top_module (
    input wire clk,
    input wire d,
    input wire r,
    output wire q
);
    reg q;

    always @(posedge clk or posedge r) begin
        if (r == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule
