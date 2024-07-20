module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;
    reg [31:0] q_temp;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q_temp <= {q[30:0], q[0] ^ q[21] ^ q[1]};
            q <= q_temp;
        end
    end

endmodule
