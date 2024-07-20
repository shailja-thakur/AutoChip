module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output [7:0] q);

    reg [7:0] q;

    always @(posedge clk or areset) begin
        if (areset) begin
            q <= 8'b0;
        end else begin
            q <= d;
        end
    end

endmodule
