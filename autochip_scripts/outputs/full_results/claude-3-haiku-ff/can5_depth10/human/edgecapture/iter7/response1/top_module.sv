module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] prev_in;

always @(posedge clk) begin
    if (reset) begin
        out <= 0;
        prev_in <= 0;
    end
    else begin
        for (int i = 0; i < 32; i++) begin
            if (in[i] == 0 && prev_in[i] == 1) begin
                out[i] <= 1;
            end
            else if (in[i] != prev_in[i]) begin
                out[i] <= 0;
            end
            else begin
                out[i] <= out[i];
            end
            prev_in[i] <= in[i];
        end
    end
end

endmodule
