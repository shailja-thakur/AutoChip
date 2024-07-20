module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (in & ~prev_in); // Set output when 0 to 1 transition occurs
        prev_in <= in; // Save current input for next clock cycle
    end
endmodule
