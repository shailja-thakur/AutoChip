module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'b1;
        end else begin
            q <= {q[30:0], q[22] ^ q[0] ^ q[1] ^ q[31]};
        end
    end

endmodule
