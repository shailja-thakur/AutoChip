module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in; // Store the previous value of 'in' on every clock edge

    // Detect edge transitions
    anyedge[0] <= (in[0] && !in_prev[0]);
    anyedge[1] <= (in[1] && !in_prev[1]);
    anyedge[2] <= (in[2] && !in_prev[2]);
    anyedge[3] <= (in[3] && !in_prev[3]);
    anyedge[4] <= (in[4] && !in_prev[4]);
    anyedge[5] <= (in[5] && !in_prev[5]);
    anyedge[6] <= (in[6] && !in_prev[6]);
    anyedge[7] <= (in[7] && !in_prev[7]);
end

endmodule
