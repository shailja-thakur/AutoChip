module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always_ff @(posedge clk or posedge ar) begin
    if (ar)
        q <= 1'b0;  // asynchronous reset
    else
        q <= d;     // store data on rising edge of clock
end

endmodule
