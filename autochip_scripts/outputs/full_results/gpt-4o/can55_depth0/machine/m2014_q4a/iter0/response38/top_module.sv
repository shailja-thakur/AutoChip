module top_module (
    input d,
    input ena,
    output reg q
);

    always @(*) begin
        if (ena)
            q = d;
        // If ena is low, q remains unchanged.
    end

endmodule
