module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            next_q = {q[30:0], q[22:0]^q[1]^q[0]};
            q <= next_q;
        end
    end

endmodule
