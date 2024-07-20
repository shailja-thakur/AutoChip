module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar)
            q <= 1'b0;  // Asynchronous reset sets q to 0
        else
            q <= d;     // On the rising edge of the clock, q takes the value of d
    end

endmodule
