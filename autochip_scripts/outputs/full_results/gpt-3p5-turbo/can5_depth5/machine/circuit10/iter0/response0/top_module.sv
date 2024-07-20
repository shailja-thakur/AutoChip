module top_module(
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg c; // Declare c as a register

always@(posedge clk) begin // Use always block to update c on every rising edge of the clock
    c <= (a & b) | (a & c) | (b & c); // Calculate the new value of c
end

always@(posedge clk) begin // Use always block to update the outputs q and state on every rising edge of the clock
    q <= a ^ b ^ c; // Calculate the new value of q
    state <= c; // Assign the value of c to state
end

endmodule
