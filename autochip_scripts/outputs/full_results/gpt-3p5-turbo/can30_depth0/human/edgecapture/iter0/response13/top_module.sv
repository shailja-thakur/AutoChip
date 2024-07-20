module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] reg_out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            reg_out <= 0;
        else begin
            for (integer i = 0; i < 32; i = i + 1) begin
                if (in[i] & ~in[i+1])
                    reg_out[i] <= 1;
                else
                    reg_out[i] <= 0;
            end
        end
    end

    assign out = reg_out;

endmodule
