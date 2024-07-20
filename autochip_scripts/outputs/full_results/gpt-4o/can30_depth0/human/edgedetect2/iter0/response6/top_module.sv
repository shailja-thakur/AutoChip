module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        // Detect any edge (change from one clock cycle to the next)
        anyedge <= (in ^ prev_in);
        // Update previous input
        prev_in <= in;
    end

endmodule
