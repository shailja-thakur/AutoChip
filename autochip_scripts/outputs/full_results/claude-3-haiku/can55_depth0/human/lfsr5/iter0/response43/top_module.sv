module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

wire feedback;

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end
    else begin
        feedback = q[0] ^ q[2];
        q <= {feedback, q[4:1]};
    end
end

endmodule
