module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    reg [15:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 16'b0000;
            ena <= 3'b0;
        end else begin
            if (q[3:0] == 4'b1001) begin
                next_q[3:0] <= 4'b0000;
                if (q[7:4] == 4'b1001) begin
                    next_q[7:4] <= 4'b0000;
                    if (q[11:8] == 4'b1001) begin
                        next_q[11:8] <= 4'b0000;
                        if (q[15:12] == 4'b1001)
                            next_q[15:12] <= 4'b0000;
                        else
                            next_q[15:12] <= q[15:12] + 4'b0001;
                    end else
                        next_q[11:8] <= q[11:8] + 4'b0001;
                end else
                    next_q[7:4] <= q[7:4] + 4'b0001;
            end else
                next_q[3:0] <= q[3:0] + 4'b0001;

            ena <= (next_q[2:0] == 3'b100) ? 3'b111 : 3'b000;
        end
    end
    
    always @(posedge clk) begin
        if (reset)
            q <= 16'b0000;
        else
            q <= next_q;
    end
endmodule
