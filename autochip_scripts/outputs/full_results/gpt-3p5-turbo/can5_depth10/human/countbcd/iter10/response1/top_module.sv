module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b0;
        end else begin
            if (q[3:0] == 4'b1001)
                q[3:0] <= 4'b0000;
            else
                q[3:0] <= q[3:0] + 4'b0001;

            if (q[3:1] == 3'b100)
                ena <= 3'b111;
            else
                ena <= 3'b000;

            if (q[3:1] == 3'b100) begin
                if (q[3:1] == 3'b100)
                    q[7:4] <= q[7:4] + 4'b0001;
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    q[11:8] <= q[11:8] + 4'b0001;
                end
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    q[15:12] <= q[15:12] + 4'b0001;
                end
                if (q[15:12] == 4'b1001)
                    q[15:12] <= 4'b0000;
            end
        end
    end
endmodule
