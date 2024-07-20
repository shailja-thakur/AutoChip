module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
    always_ff @(posedge clk or posedge ar) begin
        if (ar)
            q <= 0; // Asynchronous reset
        else
            q <= d; // Positive edge triggered
    end
endmodule
