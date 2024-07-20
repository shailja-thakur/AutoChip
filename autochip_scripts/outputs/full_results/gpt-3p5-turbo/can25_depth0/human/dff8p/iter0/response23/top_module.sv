module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] internal_q;
    reg reset_sync;

    always @(posedge clk)
    begin
        if (reset)
            reset_sync <= 1'b1;
        else
            reset_sync <= 1'b0;
    end

    always @(negedge clk or posedge reset_sync)
    begin
        if (reset_sync)
            internal_q <= 8'h34;
        else
            internal_q <= d;
    end

    assign q = internal_q;

endmodule
