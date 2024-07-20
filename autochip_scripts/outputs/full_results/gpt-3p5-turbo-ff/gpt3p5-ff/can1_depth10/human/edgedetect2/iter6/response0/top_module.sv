module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;

    for (integer i=0; i<8; i=i+1) begin
        if (in[i] && !in_prev[i])
            anyedge[i] <= 1;
        else
            anyedge[i] <= 0;
    end
end

initial begin
    anyedge <= 8'b0;
end

endmodule
