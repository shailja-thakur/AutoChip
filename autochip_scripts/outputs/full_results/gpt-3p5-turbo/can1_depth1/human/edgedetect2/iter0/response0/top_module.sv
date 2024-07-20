module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] previous_in;

    always @(posedge clk) begin
        previous_in <= in; // save the previous value of in at every clock cycle
    end

    always @(posedge clk) begin
        anyedge <= in & (~previous_in); // detect edges by comparing the current value of in with the previous value
    end
endmodule
