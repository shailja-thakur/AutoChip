module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Internal signals for enables
    reg [3:0] ones, tens, hundreds, thousands;

    // Generate enable signals for digits 1 to 3
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (tens == 4'd9) & ena[1];
    assign ena[3] = (hundreds == 4'd9) & ena[2];

    // Synchronous reset and counter logic
    always @(posedge clk) begin
        if (reset) begin
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
                            thousands <= thousands + 4'd1;
                        end
                    end else begin
                        hundreds <= hundreds + 4'd1;
                    end
                end else begin
                    tens <= tens + 4'd1;
                end
            end else begin
                ones <= ones + 4'd1;
            end
        end
        // Concatenate the digits to form the final output
        q <= {thousands, hundreds, tens, ones};
    end
endmodule
