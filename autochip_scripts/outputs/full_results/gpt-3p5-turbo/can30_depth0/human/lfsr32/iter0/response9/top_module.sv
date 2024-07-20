module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 32'h1;
            q <= 32'h1;
        end else begin
            state <= {state[30:0], state[0] ^ state[9] ^ state[29] ^ state[30]};
            q <= state;
        end
    end

endmodule
