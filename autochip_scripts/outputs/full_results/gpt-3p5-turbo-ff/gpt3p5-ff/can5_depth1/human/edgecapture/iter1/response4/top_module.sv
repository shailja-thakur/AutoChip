module top_module(
    input wire clk,
    input wire reset,
    input wire [31:0] in,
    output reg [31:0] out
);

    reg [31:0] prev_in;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 32'b0;
        else
            prev_in <= in;
    end

    always @(posedge clk) begin
        out <= prev_in & ~in;
    end

endmodule
