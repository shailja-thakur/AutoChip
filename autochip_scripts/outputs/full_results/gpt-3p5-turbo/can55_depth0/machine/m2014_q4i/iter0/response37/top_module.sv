module top_module(
    output reg out); // Adding reg keyword to declare out as a register

    always @(posedge clk) begin // Adding a clock signal to make the module sequential
        out <= 1'b0; // Assigning 0 to out
    end
    
endmodule
