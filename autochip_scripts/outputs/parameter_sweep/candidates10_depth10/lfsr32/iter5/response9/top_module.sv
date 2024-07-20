module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] next_q;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= next_q;
        end
    end

    always @* begin
        next_q[31] = q[30] ^ q[21] ^ q[1] ^ q[0];
        next_q[30:1] = q[29:0];
    end

endmodule
