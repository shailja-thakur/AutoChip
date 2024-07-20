module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b000;
        end
        else begin
            q <= q + 1;
            if (q[3:1] >= 3'b101) begin
                ena <= 3'b000;
            end
            else begin
                ena <= {ena[2], ena[1], ena[0]};
            end
        end
    end
endmodule
