module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;
        else
            q <= {q[3:0], q[4] ^ q[2]};
    end

endmodule
