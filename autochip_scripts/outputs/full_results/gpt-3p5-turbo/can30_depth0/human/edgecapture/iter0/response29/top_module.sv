module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_in <= 32'h0;
        else
            prev_in <= in;
    end

    always @(*) begin
        out = 32'h0;
        for (int i = 0; i < 32; i = i + 1) begin
            if (prev_in[i] && !in[i])
                out[i] = 1'b1;
        end
    end

endmodule
