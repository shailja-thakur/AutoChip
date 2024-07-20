module top_module(
    output reg out);

    // Assign out to 0
    always @(out)
    begin
        out <= 0;
    end

endmodule
