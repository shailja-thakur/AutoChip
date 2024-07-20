module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena[1]) begin
                q[3:0] <= q[3:0] + 1;  // ones digit increment
            end
            if (ena[2]) begin
                q[7:4] <= q[7:4] + 1;  // tens digit increment
            end
            if (ena[3]) begin
                q[11:8] <= q[11:8] + 1;  // hundreds digit increment
            end
            if (ena[4]) begin
                q[15:12] <= q[15:12] + 1;  // thousands digit increment
            end
        end
    end
    
endmodule
