module top_module (
    input wire clk,
    input wire d,
    input wire ar,
    output reg q
);

always @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
