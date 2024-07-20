module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    // Declare internal signals
    reg [3:0] ones, tens, hunds, thous;

    // Combinational logic to generate enable signals
    assign ena[1] = (tens == 4'b1001); // Tens digit reached 9, enable increment of hundreds digit
    assign ena[2] = (hunds == 4'b1001); // Hundreds digit reached 9, enable increment of thousands digit
    assign ena[3] = (thous == 4'b1001); // Thousands digit reached 9, enable increment is not needed

    // Sequential logic for BCD counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hunds <= 4'b0000;
            thous <= 4'b0000;
        end
        else begin
            // Increment ones digit
            if (ones == 4'b1001) begin
                ones <= 4'b0000;
                // Increment tens digit if ones digit reached 9
                if (ena[1]) begin
                    tens <= tens + 4'b0001;
                end
            end
            else begin
                ones <= ones + 4'b0001;
            end

            // Increment tens digit
            if (ena[1] && (tens == 4'b1001)) begin
                tens <= 4'b0000;
                // Increment hundreds digit if tens digit reached 9
                if (ena[2]) begin
                    hunds <= hunds + 4'b0001;
                end
            end

            // Increment hundreds digit
            if (ena[2] && (hunds == 4'b1001)) begin
                hunds <= 4'b0000;
                // Increment thousands digit if hundreds digit reached 9
                if (ena[3]) begin
                    thous <= thous + 4'b0001;
                end
            end

            // Increment thousands digit
            if (ena[3] && (thous == 4'b1001)) begin
                thous <= 4'b0000;
            end
        end
    end

    // Combine the BCD digits into a 16-bit output
    always @* begin
        q = {thous, hunds, tens, ones};
    end

endmodule
