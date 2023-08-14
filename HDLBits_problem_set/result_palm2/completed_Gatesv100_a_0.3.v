module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    // Create a shift register for the input vector.
    shiftreg [99:0] in_reg;

    // Create a 1-bit counter for the output vector.
    reg [99:0] counter;

    // Initialize the shift register and counter.
    always @(posedge clk) begin
        in_reg <= in;
        counter <= counter + 1;
    end

    // Generate the output vector out_both.
    always @(posedge clk) begin
        out_both[counter] <= in_reg[counter] & in_reg[counter - 1];
    end

    // Generate the output vector out_any.
    always @(posedge clk) begin
        out_any[counter] <= in_reg[counter] | in_reg[counter - 1];
    end

    // Generate the output vector out_different.
    always @(posedge clk) begin
        out_different[counter] <= in_reg[counter] ^ in_reg[counter - 1];
    end

endmodule