module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;

always @(posedge clk) begin
    anyedge <= 0;
    for (int i=0; i<8; i=i+1) begin
        if (in[i] && !prev_cycle[i])
            anyedge[i] <= 1;
    end
    prev_cycle <= in;
end

endmodule
