module top_module(
    input wire a,
    input wire b,
    output wire out);

    xor gate1 (
        input wire a,
        input wire b,
        output wire out);

    begin
        out <= gate1.out;
    end

endmodule