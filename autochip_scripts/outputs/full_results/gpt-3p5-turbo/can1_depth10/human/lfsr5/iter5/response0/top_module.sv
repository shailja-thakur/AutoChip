module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [2:0] taps;

    always @* begin
        if (reset) 
            q <= 1;
        else begin
            taps = {q[4], q[2], 1'b0};
            q <= {q[3:0], q[4] ^ q[taps]};
        end
    end

endmodule
