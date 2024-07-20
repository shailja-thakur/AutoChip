module top_module(
    input x,
    input y,
    output z);

// D flip-flop for storing the previous value of x
reg x_prev;
always @(posedge clk) begin
    x_prev <= x;
end

// D flip-flop for storing the previous value of y
reg y_prev;
always @(posedge clk) begin
    y_prev <= y;
end

// D flip-flop for storing the current value of z
reg z_reg;
always @(posedge clk) begin
    z_reg <= x_prev & z_reg;
end

// Assign output z
assign z = x & y & z_reg;

endmodule
