module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        // State Y2 logic
        Y2 = (y[1] & ~w) | (y[4] &  w); // B = A & ~w + D & w

        // State Y4 logic
        Y4 = (y[2] &  w) | (y[3] &  w) | (y[4] &  w) | (y[6] &  w); // D = B & w + C & w + D & w + F & w
    end

endmodule
