module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);
    
    // Intermediate variables for the operations
    integer i;
    reg temp_and;
    reg temp_or;
    reg temp_xor;

    always @(*) begin
        // Initialize intermediate variables
        temp_and = 1;
        temp_or = 0;
        temp_xor = 0;
        
        // Perform the logical operations over the 100-bit vector
        for (i = 0; i < 100; i = i + 1) begin
            temp_and = temp_and & in[i];
            temp_or = temp_or | in[i];
            temp_xor = temp_xor ^ in[i];
        end

        // Assign the results to the output ports
        out_and = temp_and;
        out_or = temp_or;
        out_xor = temp_xor;
    end

endmodule
