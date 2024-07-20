module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
    );
    
    // define internal signals
    reg [3:0] q_ones, q_tens, q_hundreds, q_thousands;
    
    // increment enable signals
    reg enable_tens, enable_hundreds, enable_thousands;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_ones <= 4'b0000;
            q_tens <= 4'b0000;
            q_hundreds <= 4'b0000;
            q_thousands <= 4'b0000;
        end else begin
            // increment ones digit every clock cycle
            q_ones <= q_ones + 1;

            // increment tens digit based on enable signal
            if (enable_tens) begin
                q_tens <= q_tens + 1;
            end

            // increment hundreds digit based on enable signal
            if (enable_hundreds) begin
                q_hundreds <= q_hundreds + 1;
            end

            // increment thousands digit based on enable signal
            if (enable_thousands) begin
                q_thousands <= q_thousands + 1;
            end
        end
    end
    
    // assign outputs
    assign ena = {enable_thousands, enable_hundreds, enable_tens};
    assign q = {q_thousands, q_hundreds, q_tens, q_ones};
    
endmodule
