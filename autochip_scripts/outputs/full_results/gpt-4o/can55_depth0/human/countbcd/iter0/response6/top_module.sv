module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

    // Internal signal for individual BCD digits
    wire [3:0] units, tens, hundreds, thousands;
    
    // Assign each BCD digit to a portion of q
    assign units = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];
    
    // Output enable signals for digits [3:1]
    assign ena[1] = (units == 4'b1001);
    assign ena[2] = ena[1] && (tens == 4'b1001);
    assign ena[3] = ena[2] && (hundreds == 4'b1001);

    // Always block triggered on clock edges
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset
            q <= 16'b0;
        end
        else begin
            // Increment the units digit
            if (units == 4'b1001) begin
                q[3:0] <= 4'b0000;
                // Increment the tens digit
                if (tens == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    // Increment the hundreds digit
                    if (hundreds == 4'b1001) begin
                        q[11:8] <= 4'b0000;
                        // Increment the thousands digit
                        if (thousands == 4'b1001) begin
                            q[15:12] <= 4'b0000;
                        end
                        else begin
                            q[15:12] <= thousands + 1;
                        end
                    end
                    else begin
                        q[11:8] <= hundreds + 1;
                    end
                end
                else begin
                    q[7:4] <= tens + 1;
                end
            end
            else begin
                q[3:0] <= units + 1;
            end
        end
    end
endmodule
