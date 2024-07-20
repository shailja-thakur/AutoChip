module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    reg [3:0] ones, tens, hundreds, thousands;
    
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (ena[1] & (tens == 4'd9));
    assign ena[3] = (ena[2] & (hundreds == 4'd9));
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
            q <= 16'd0;
        end
        else begin
            // Increment ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Increment tens digit
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Increment hundreds digit
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Increment thousands digit
                        if (thousands == 4'd9) begin
                            thousands <= 4'd0;
                        end
                        else begin
                            thousands <= thousands + 4'd1;
                        end
                    end
                    else begin
                        hundreds <= hundreds + 4'd1;
                    end
                end
                else begin
                    tens <= tens + 4'd1;
                end
            end
            else begin
                ones <= ones + 4'd1;
            end
            
            // Update the output register
            q <= {thousands, hundreds, tens, ones};
        end
    end

endmodule
