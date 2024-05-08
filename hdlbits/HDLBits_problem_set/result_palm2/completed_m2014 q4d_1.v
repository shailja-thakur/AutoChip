module top_module (
    input clk,
    input in, 
    output out);

    reg d;
    reg q;

    always @(posedge clk) begin
        d <= in;
        q <= d;
    end

endmodule