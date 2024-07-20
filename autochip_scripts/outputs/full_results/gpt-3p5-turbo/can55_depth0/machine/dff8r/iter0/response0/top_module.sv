module top_module(
    input wire clk,
    input wire [7:0] d,
    input wire reset,
    output reg [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0;
        end else begin
            q <= d;
        end
    end

endmodule
