module top_module(
    input clk,
    input d,
    output reg q);

    reg d_posedge, d_negedge;

    always @(posedge clk) begin
        d_posedge <= d;
    end

    always @(negedge clk) begin
        d_negedge <= d;
    end

    always @* begin
        if (clk) begin
            q = d_posedge;
        end else begin
            q = d_negedge;
        end
    end
endmodule
