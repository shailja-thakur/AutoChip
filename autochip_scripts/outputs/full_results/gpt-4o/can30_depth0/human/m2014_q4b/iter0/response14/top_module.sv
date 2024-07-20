module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Asynchronous reset
    end else begin
        q <= d;     // D flip flop operation
    end
end

endmodule
