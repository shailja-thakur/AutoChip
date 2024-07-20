module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] next_state;

    always @(posedge clk) begin
        if (reset)
            next_state <= 32'h1;
        else begin
            next_state[31] <= q[1] ^ q[21] ^ q[31];
            next_state[30:0] <= q[31:1];
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else
            q <= next_state;
    end
endmodule
