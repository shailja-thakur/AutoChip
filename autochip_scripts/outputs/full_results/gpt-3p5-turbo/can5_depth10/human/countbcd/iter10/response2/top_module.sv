module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    reg [3:0] q_temp;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b0;
        end else begin
            q_temp = q;

            if (q_temp[3:0] == 4'b1001) begin
                q_temp[3:0] <= 4'b0000;
                if (q_temp[7:4] == 4'b1001) begin
                    q_temp[7:4] <= 4'b0000;
                    if (q_temp[11:8] == 4'b1001) begin
                        q_temp[11:8] <= 4'b0000;
                        if (q_temp[15:12] == 4'b1001)
                            q_temp[15:12] <= 4'b0000;
                        else
                            q_temp[15:12] <= q_temp[15:12] + 4'b0001;
                    end else
                        q_temp[11:8] <= q_temp[11:8] + 4'b0001;
                end else
                    q_temp[7:4] <= q_temp[7:4] + 4'b0001;
            end else
                q_temp[3:0] <= q_temp[3:0] + 4'b0001;

            ena <= (q_temp[3:1] == 3'b100) ? 3'b111 : 3'b000;
            q <= q_temp;
        end
    end
endmodule
