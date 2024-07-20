module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 32'h1;
        else
            state <= {state[31] ^ state[21] ^ state[1] ^ state[0], state[31:1]};
    end

    assign q = state;

endmodule
