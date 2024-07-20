module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
        ena <= 3'b0;
    end else begin
        if (ena[1]) begin
            if (q[3:1] == 3'b100) begin
                q[3:1] <= 3'b0;
                ena[1] <= 1'b0;
            end else begin
                q[3:1] <= q[3:1] + 1;
            end
        end

        if (ena[2]) begin
            if (q[7:5] == 3'b100) begin
                q[7:5] <= 3'b0;
                ena[2] <= 1'b0;
            end else begin
                q[7:5] <= q[7:5] + 1;
            end
        end

        if (ena[3]) begin
            if (q[11:9] == 3'b100) begin
                q[11:9] <= 3'b0;
                ena[3] <= 1'b0;
            end else begin
                q[11:9] <= q[11:9] + 1;
            end
        end
    end
end

endmodule
