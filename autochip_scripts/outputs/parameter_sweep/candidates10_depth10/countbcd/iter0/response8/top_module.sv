module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            q <= q + 1;
            if (q[3:1] == 3'b111)
                ena <= 0;
            else
                ena <= {~q[3], ena[2:1]};
        end
    end
endmodule
