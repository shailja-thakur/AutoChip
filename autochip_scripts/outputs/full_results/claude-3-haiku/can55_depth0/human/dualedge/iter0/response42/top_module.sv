module top_module(
    input clk,
    input d,
    output reg q
);

reg temp_q;

// Positive edge detection
always @(posedge clk) begin
    temp_q <= d;
end

// Negative edge detection
always @(negedge clk) begin
    q <= temp_q;
end

endmodule
