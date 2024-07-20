module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);
    reg [3:0] next_q;

    always @(posedge clk) begin
        if (reset)
            next_q <= 4'b0;
        else if (slowena)
            next_q <= q + 1;
    end

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0;
        else
            q <= next_q;
    end

endmodule
