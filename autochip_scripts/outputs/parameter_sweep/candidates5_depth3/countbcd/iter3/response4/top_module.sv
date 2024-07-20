module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q
);

    reg [2:0] count;
    reg [3:0] q_temp;
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
            count <= 0;
        end else begin
            q_temp <= q;
            
            if (count == 3'b000) begin
                if (q_temp[3:0] == 4'b1001) begin
                    q_temp[3:0] <= 4'b0000;
                    ena[0] <= 1;
                    count <= 3'b001;
                end else begin
                    q_temp[3:0] <= q_temp[3:0] + 1;
                end
            end else if (count == 3'b001) begin
                if (q_temp[7:4] == 4'b1001) begin
                    q_temp[7:4] <= 4'b0000;
                    ena[1] <= 1;
                    count <= 3'b010;
                end else begin
                    q_temp[7:4] <= q_temp[7:4] + 1;
                end
            end else if (count == 3'b010) begin
                if (q_temp[11:8] == 4'b1001) begin
                    q_temp[11:8] <= 4'b0000;
                    ena[2] <= 1;
                    count <= 3'b000;
                end else begin
                    q_temp[11:8] <= q_temp[11:8] + 1;
                end
            end
            
            q <= q_temp;
        end
    end
endmodule
