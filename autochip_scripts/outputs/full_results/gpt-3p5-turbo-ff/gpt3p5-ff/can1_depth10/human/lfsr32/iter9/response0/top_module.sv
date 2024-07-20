module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;
    reg [3:0] tap_positions;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    always @*
        q_next = {q[30:0], q[21] ^ q[11] ^ q[1] ^ q[0]};

endmodule
