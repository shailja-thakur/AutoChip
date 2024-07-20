module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

// Declare a register to store the data
logic register_data;

// Trigger the register on the rising edge of the clock
always @(posedge clk) begin
    // Check if reset is active
    if (r) begin
        // Set the output of the register to 0
        register_data <= 0;
    end else begin
        // Set the output of the register to the input data
        register_data <= d;
    end
end

// Assign the output of the register to the module output
assign q = register_data;

endmodule
