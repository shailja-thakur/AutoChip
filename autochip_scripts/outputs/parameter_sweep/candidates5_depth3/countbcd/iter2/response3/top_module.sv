module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q
);

    reg [2:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
            count <= 0;
        end else begin
            if (count == 3'b000) begin
                if (q[3:0] == 9) begin
                    q[3:0] <= 0;
                    ena[2] <= 1;
                    count <= 3'b001;
                end else begin
                    q[3:0] <= q[3:0] + 1;
                end
            end else if (count == 3'b001) begin
                if (q[7:4] == 9) begin
                    q[7:4] <= 0;
                    ena[1] <= 1;
                    count <= 3'b010;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end else if (count == 3'b010) begin
                if (q[11:8] == 9) begin
                    q[11:8] <= 0;
                    ena[0] <= 1;
                    count <= 3'b000;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
        end
    end
endmodule
