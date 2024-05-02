module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            if (ena[3]) begin
                q[12:8] <= q[8:4] + 1;
            end
            if (ena[2]) begin
                q[4:0] <= q[8:4] + 1;
            end
            if (ena[1]) begin
                q[12:8] <= q[4:0] + 1;
            end
        end
    end

    assign ena[3] = q[15] == 15'b1;
    assign ena[2] = q[11] == 15'b1;
    assign ena[1] = q[7] == 15'b1;

endmodule