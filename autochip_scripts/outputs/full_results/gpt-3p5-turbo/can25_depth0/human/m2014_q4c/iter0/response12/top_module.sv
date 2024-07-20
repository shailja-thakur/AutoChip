module top_module (
    input clk,
    input d,
    input r,
    output logic q
);
    
    // Declare a temporary logic signal for the flip flop output
    logic temp_q;

    // Declare a temporary logic signal for the inverted reset
    logic reset_n;

    // Assign the inverted reset signal
    assign reset_n = ~r;

    // Create the D flip flop with active high synchronous reset
    always @(posedge clk or posedge reset_n) begin
        if (reset_n)
            temp_q <= 0;
        else
            temp_q <= d;
    end

    // Assign the output of the flip flop to q
    assign q = temp_q;

endmodule
