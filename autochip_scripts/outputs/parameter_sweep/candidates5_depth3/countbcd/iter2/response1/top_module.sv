module top_module(
    input clk,
    input reset,
    output [2:0] ena,
    output reg [15:0] q
);

    reg [2:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 3'b000;
            count <= 0;
        end else begin
            if (count == 3'b000) begin
                if (q[3:0] == 4'b1001) begin
                    q[3:0] <= 0;
                    ena <= {3'b001};
                    count <= 3'b001;
                end else begin
                    q[3:0] <= q[3:0] + 1;
                end
            end else if (count == 3'b001) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 0;
                    ena <= {3'b010};
                    count <= 3'b010;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                end
            end else if (count == 3'b010) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 0;
                    ena <= {3'b100};
                    count <= 3'b000;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
        end
    end
endmodule
