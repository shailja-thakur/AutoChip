module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    always @(posedge clk) begin
        for (int i = 0; i < 8; i++) begin
            anyedge[i] <= (in[i] & ~prev_in[i]) | (~in[i] & prev_in[i]);
        end
        prev_in <= in;
    end

endmodule