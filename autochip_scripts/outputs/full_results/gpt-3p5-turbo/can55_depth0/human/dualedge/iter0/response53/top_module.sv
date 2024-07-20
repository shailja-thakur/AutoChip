module top_module(
    input wire clk,
    input wire d,
    output reg q);

    reg q_int;

    always @(posedge clk) begin
        q_int <= d; // Store the input on the rising edge
    end

    always @(negedge clk) begin
        q <= q_int; // Output the stored value on the falling edge
    end

endmodule
