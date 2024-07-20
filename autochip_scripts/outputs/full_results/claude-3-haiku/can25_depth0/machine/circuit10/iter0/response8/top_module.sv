module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg c;

    // Register to store the value of c
    always @(posedge clk) begin
        c <= (a & b) | (a & c) | (b & c);
    end

    // Calculate the output q
    assign q = a ^ b ^ c;

    // Output the value of c as state
    assign state = c;

endmodule
