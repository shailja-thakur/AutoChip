module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] nextState;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        nextState <= 32'h1;
    end
    else begin
        nextState <= {q[21:0], q[31]^q[21]^q[1]^q[0]};
    end
end

always @(posedge clk) begin
    q <= nextState;
end

endmodule
