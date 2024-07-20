module top_module(
    input wire clk,
    input wire [7:0] d,
    input wire areset,
    output wire reg [7:0] q
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end

endmodule
