module top_module(
    input wire a,
    input wire b,
    output wire out);

    always @(a or b) begin
        out <= !(a | b);
    end

endmodule