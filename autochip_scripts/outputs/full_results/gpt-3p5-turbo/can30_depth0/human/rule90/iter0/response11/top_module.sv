module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= {q[510:0], q[511]} ^ {q[512], q[511:1]};
    end

endmodule
