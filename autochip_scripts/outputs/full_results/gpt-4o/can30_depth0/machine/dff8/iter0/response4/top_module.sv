module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output to 8'h0
    initial begin
        q = 8'h00;
    end

    // On the rising edge of clk, store d in q
    always @(posedge clk) begin
        q <= d;
    end
endmodule
