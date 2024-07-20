module top_module(
    input clk,
    input d,
    output reg q
);

// Initial block to set the initial value of q to 1'hx
initial begin
    q <= 1'hx;
end

// Always block that triggers on the rising edge of the clock signal
always @(posedge clk) begin
    q <= d;
end

endmodule
