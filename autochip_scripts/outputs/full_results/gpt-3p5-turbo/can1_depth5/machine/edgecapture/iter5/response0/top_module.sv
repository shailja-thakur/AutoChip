module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] d_last;
    reg [31:0] prev_in;
    wire clk_edge;

    assign clk_edge = clk & ~d_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            d_last <= 0;
        end
        else begin
            d_last <= in;
            if (clk_edge) begin
                out <= out | (~prev_in & d_last);
            end
        end
        
        prev_in <= in;
    end

endmodule
