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
            if (q[3:1] == 3'b100) begin
                ena <= 0;
            end else begin
                ena <= ena << 1;
            end
        end
    end

endmodule
