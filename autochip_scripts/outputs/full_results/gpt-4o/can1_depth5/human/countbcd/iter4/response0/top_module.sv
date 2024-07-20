module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    reg [3:0] ones, tens, hundreds, thousands;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Increment ones place
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Increment tens place
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Increment hundreds place
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Increment thousands place
                        if (thousands == 4'd9) begin
                            thousands <= 4'd0;
                        end else begin
                            thousands <= thousands + 1'd1;
                        end
                    end else begin
                        hundreds <= hundreds + 1'd1;
                    end
                end else begin
                    tens <= tens + 1'd1;
                end
            end else begin
                ones <= ones + 1'd1;
            end

            // Update enable signals
            ena[1] <= (ones == 4'd9) ? 1'b1 : 1'b0;
            ena[2] <= (ones == 4'd9 && tens == 4'd9) ? 1'b1 : 1'b0;
            ena[3] <= (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9) ? 1'b1 : 1'b0;

            // Update the concatenated output
            q <= {thousands, hundreds, tens, ones};
        end
    end

endmodule
