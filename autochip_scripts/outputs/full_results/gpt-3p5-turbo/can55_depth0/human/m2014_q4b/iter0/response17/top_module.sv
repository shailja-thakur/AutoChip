module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always_ff @(posedge clk or negedge ar) begin
    if (~ar) // Asynchronous reset
        q <= 1'b0;
    else
        q <= d; // D input
end

endmodule
