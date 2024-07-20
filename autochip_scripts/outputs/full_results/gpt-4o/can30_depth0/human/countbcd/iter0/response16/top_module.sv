module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    // Internal signal for each digit
    reg [3:0] ones, tens, hundreds, thousands;
    
    // Update each digit counter and generate enables
    always @ (posedge clk) begin
        if (reset) begin
            // Reset all counters to 0
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
            ena <= 3'b000;
        end
        else begin
            // Increment ones digit counter
            if (ones == 9) begin
                ones <= 0;
                tens <= tens + 1;
                ena[1] <= 1;
            end
            else begin
                ones <= ones + 1;
                ena[1] <= 0;
            end
            
            // Increment tens digit counter if neccessary
            if (ena[1]) begin
                if (tens == 9) begin
                    tens <= 0;
                    hundreds <= hundreds + 1;
                    ena[2] <= 1;
                end
                else begin
                    tens <= tens + 1;
                    ena[2] <= 0;
                end
            end
            
            // Increment hundreds digit counter if neccessary
            if (ena[2]) begin
                if (hundreds == 9) begin
                    hundreds <= 0;
                    thousands <= thousands + 1;
                    ena[3] <= 1;
                end
                else begin
                    hundreds <= hundreds + 1;
                    ena[3] <= 0;
                end
            end
            
            // Increment thousands digit counter if neccessary
            if (ena[3]) begin
                if (thousands == 9) begin
                    thousands <= 0;
                end
                else begin
                    thousands <= thousands + 1;
                end
            end
            else begin
                ena[3] <= 0;
            end
        end
    end
    
    // Concatenate all digits into the output q
    always @(*) begin
        q = {thousands, hundreds, tens, ones};
    end
endmodule
