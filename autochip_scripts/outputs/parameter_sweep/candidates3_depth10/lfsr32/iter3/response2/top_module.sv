module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            d <= {q[22:0]^q[1]^q[0], q[31:1]};
            q <= d;
        end
    end

endmodule
