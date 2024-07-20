module top_module (
    input d,
    input ena,
    output reg q // Changed from logic to reg to work inside an always block
);

    always @* begin
        if (ena) begin
            q = d;
        end
    end
endmodule
