module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    reg [7:0] internal_q;

    always @(posedge clk or posedge areset) begin
        if (areset)
            internal_q <= 8'b0;
        else
            internal_q <= d;
    end

    assign q = internal_q;

endmodule
