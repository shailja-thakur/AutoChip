module top_module(
    input clk,
    input d,
    output reg q);

reg q_reg; // intermediate register to store the previous value of q

// always block triggered on the rising edge of the clock
always @(posedge clk) begin
    q_reg <= q; // store previous value of q
    q <= d; // update q with the new value of d
end

// always block triggered on the falling edge of the clock
always @(negedge clk) begin
    q <= q_reg; // update q with the previous value of q
end

endmodule
