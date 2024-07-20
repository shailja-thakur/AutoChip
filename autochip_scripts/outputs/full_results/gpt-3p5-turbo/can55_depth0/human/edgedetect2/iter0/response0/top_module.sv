module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;
    anyedge <= 0;
end

always @(posedge clk) begin
    if (in[0] && !in_prev[0]) begin
        anyedge[0] <= 1;
    end
    if (in[1] && !in_prev[1]) begin
        anyedge[1] <= 1;
    end
    if (in[2] && !in_prev[2]) begin
        anyedge[2] <= 1;
    end
    if (in[3] && !in_prev[3]) begin
        anyedge[3] <= 1;
    end
    if (in[4] && !in_prev[4]) begin
        anyedge[4] <= 1;
    end
    if (in[5] && !in_prev[5]) begin
        anyedge[5] <= 1;
    end
    if (in[6] && !in_prev[6]) begin
        anyedge[6] <= 1;
    end
    if (in[7] && !in_prev[7]) begin
        anyedge[7] <= 1;
    end
end

endmodule
