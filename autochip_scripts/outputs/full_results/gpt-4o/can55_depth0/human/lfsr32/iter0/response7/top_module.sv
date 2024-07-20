module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q[0], q[31:1]} ^ {q[1:0] == 2'b01, {(q[22] ^ q[1])}, 1'b0} << 21;
        end
    end
endmodule
