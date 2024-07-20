module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] prev_in;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
            prev_in <= 0;
        end else begin
            for (int i=0; i<32; i=i+1) begin
                if (prev_in[i] && in[i]==0)
                    out[i] <= 1;
                else
                    out[i] <= 0;
            end
            prev_in <= in;
        end
    end

    // Add initial block
    initial begin
        out <= 0;
        prev_in <= 0;
    end

endmodule
