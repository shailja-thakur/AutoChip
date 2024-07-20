module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] d;

    always @(posedge clk) begin
        if(reset) begin
            q <= 1'b1;
        end else begin
            d <= {q[0] ^ q[20] ^ q[29] ^ q[31], q[31:1]};
            q <= d;
        end
    end

endmodule
