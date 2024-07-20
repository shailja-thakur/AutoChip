module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] previous_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            previous_in <= 32'b0;
        end else begin
            for (int i = 0; i < 32; i = i + 1) begin
                if (previous_in[i] & ~in[i])
                    out[i] <= 1'b1;
            end
            previous_in <= in;
        end
    end

endmodule
