module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);

    always @(posedge clk) begin
        for (int i = 0; i < 8; i++) begin
            if (in[i] == 0 && in[i + 1] == 1) begin
                pedge[i] = 1;
            end
        end
    end

endmodule