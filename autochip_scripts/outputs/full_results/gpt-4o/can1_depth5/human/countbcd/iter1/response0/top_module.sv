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
            // Ones place handling
            if (ones == 4'd9) begin
                ones <= 4'd0;
                ena[1] <= 1'b1; // Enable tens place increment
            end else begin
                ones <= ones + 1'b1;
                ena[1] <= 1'b0;
            end

            // Tens place handling
            if (ena[1]) begin
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    ena[2] <= 1'b1; // Enable hundreds place increment
                end else begin
                    tens <= tens + 1'b1;
                    ena[2] <= 1'b0;
                end
            end

            // Hundreds place handling
            if (ena[2]) begin
                if (hundreds == 4'd9) begin
                    hundreds <= 4'd0;
                    ena[3] <= 1'b1; // Enable thousands place increment
                end else begin
                    hundreds <= hundreds + 1'b1;
                    ena[3] <= 1'b0;
                end
            end

            // Thousands place handling
            if (ena[3]) begin
                if (thousands == 4'd9) begin
                    thousands <= 4'd0;
                end else begin
                    thousands <= thousands + 1'b1;
                end
            end

            // Update the concatenated output
            q <= {thousands, hundreds, tens, ones};
        end
    end
endmodule
