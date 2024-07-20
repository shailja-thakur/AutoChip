module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

wire feedback;

always @(posedge clk) begin
    if (reset)
        q <= 5'b00001;
    else begin
        feedback = q[4] ^ q[2];
        q <= {q[3:0], feedback};
    end
end

endmodule
