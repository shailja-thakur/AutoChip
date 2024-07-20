module top_module (
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 32'h1;
    end else begin
        state <= {state[30:0], state[31] ^ state[21] ^ state[1] ^ state[0]};
    end
end

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= state;
    end
end

endmodule
