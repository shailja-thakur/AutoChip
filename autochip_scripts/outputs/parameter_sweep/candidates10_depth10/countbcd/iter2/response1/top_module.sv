module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

reg [3:0] q_temp;

always @(posedge clk) begin
    if(reset) begin
        q <= 16'b0;
        q_temp <= 4'b0;
        ena <= 3'b0;
    end else begin
        q_temp <= q_temp + 1;
        if(q_temp[3:0] == 4'b10) begin
            q_temp[3:0] <= 4'b0;
            ena[1] <= 1;
        end else begin
            ena[1] <= 0;
        end
        if(q_temp[7:4] == 4'b10) begin
            q_temp[7:4] <= 4'b0;
            ena[2] <= 1;
        end else begin
            ena[2] <= 0;
        end
        if(q_temp[11:8] == 4'b10) begin
            q_temp[11:8] <= 4'b0;
            ena[3] <= 1;
        end else begin
            ena[3] <= 0;
        end
        if(q_temp[15:12] == 4'b10) begin
            q_temp[15:12] <= 4'b0;
        end
    end
end

always @(posedge clk) begin
    if(reset) begin
        q <= 16'b0;
    end else begin
        q <= q_temp;
    end
end

endmodule
