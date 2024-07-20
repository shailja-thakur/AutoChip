module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        in_prev <= in;

        // Detect any edge
        if (in != in_prev) begin
            anyedge <= in;
        end
    end

endmodule
