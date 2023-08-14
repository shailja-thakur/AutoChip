module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] prev_in;
    reg [7:0] anyedge;

    always @(posedge clk) begin
        if (in[7]) begin
            anyedge[7] <= 1;
        end else begin
            anyedge[7] <= anyedge[7 - 1];
        end
        for (int i = 6; i >= 0; i--) begin
            if (in[i] != prev_in[i]) begin
                anyedge[i] <= 1;
            end else begin
                anyedge[i] <= anyedge[i + 1];
            end
        end
        prev_in <= in;
    end

endmodule