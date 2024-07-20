module top_module(
    output reg zero);

    // Assign the value 0 to the output zero
    always @(posedge clk) begin
        zero <= 0;
    end
    
endmodule
