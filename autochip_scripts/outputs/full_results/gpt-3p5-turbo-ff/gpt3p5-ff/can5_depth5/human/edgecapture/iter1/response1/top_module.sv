module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;
    reg [31:0] temp_out;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            prev_in <= 0;
        end else begin
            temp_out <= 0;
            for (int i = 0; i < 32; i = i + 1) begin
                if (prev_in[i] && !in[i]) begin
                    temp_out[i] <= 1;
                end
            end
            out <= out | temp_out;
            prev_in <= in;
        end
    end

endmodule
