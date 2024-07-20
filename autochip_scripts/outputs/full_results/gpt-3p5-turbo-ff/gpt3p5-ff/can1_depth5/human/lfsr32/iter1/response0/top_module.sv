module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else begin
            q <= {q[31:1], q[22] ^ q[1]};
        end
    end

endmodule
