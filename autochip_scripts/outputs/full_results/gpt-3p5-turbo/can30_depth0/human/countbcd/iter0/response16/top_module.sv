module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            if (q[3:1] == 7) begin
                q[3:1] <= 0;
                ena <= 0;
            end else begin
                q[3:1] <= q[3:1] + 1;
                ena <= 1;
            end
        end
    end

endmodule
