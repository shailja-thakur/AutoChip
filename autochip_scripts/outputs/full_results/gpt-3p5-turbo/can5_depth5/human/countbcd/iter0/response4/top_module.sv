module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    reg [15:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 0;
        end else begin
            if (ena[3]) begin
                next_q[3:0] <= q[3:0] + 1;
            end 

            if (ena[2]) begin
                next_q[7:4] <= q[7:4] + 1;
            end 

            if (ena[1]) begin
                next_q[11:8] <= q[11:8] + 1;
            end 

            next_q[15:12] <= q[15:12];
        end
    end

    always @(posedge clk) begin
        q <= next_q;
    end
endmodule
