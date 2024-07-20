module top_module (
    input clk, // Clock signal
    input d,   // Data input
    input ar,  // Asynchronous reset signal
    output logic q // Output
);
    always @(posedge clk or posedge ar) begin
        if (ar)
            q <= 0;  // Reset the register to 0 on asynchronous reset signal
        else if (clk)
            q <= d;  // Store the value of the data input in the register on clock signal
    end
endmodule
