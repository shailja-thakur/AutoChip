module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

    // Internal signals for the enable lines
    reg [3:0] ones, tens, hundreds, thousands;

    // Enable signals for each digit ([3:1])
    assign ena[1] = ones == 4'd9;           // Enable tens digit when ones digit overflows
    assign ena[2] = ena[1] && tens == 4'd9; // Enable hundreds digit when tens digit overflows
    assign ena[3] = ena[2] && hundreds == 4'd9; // Enable thousands digit when hundreds digit overflows

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Ones place update
            if (ones == 4'd9) begin
                ones <= 4'd0;
            end else begin
                ones <= ones + 4'd1;
            end
            
            // Tens place update
            if (ena[1]) begin
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                end else begin
                    tens <= tens + 4'd1;
                end
            end
            
            // Hundreds place update
            if (ena[2]) begin
                if (hundreds == 4'd9) begin
                    hundreds <= 4'd0;
                end else begin
                    hundreds <= hundreds + 4'd1;
                end
            end

            // Thousands place update
            if (ena[3]) begin
                if (thousands == 4'd9) begin
                    thousands <= 4'd0;
                end else begin
                    thousands <= thousands + 4'd1;
                end
            end

            q <= {thousands, hundreds, tens, ones};
        end
    end
endmodule
