module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] ones, tens, hundreds, thousands;
    wire ena_ones, ena_tens, ena_hundreds;

    // Assign enable signals for each digit
    assign ena[1] = ena_tens;
    assign ena[2] = ena_hundreds;
    assign ena[3] = (ones == 4'd9) && (tens == 4'd9) && (hundreds == 4'd9);

    // Increment enable conditions
    assign ena_tens = (ones == 4'd9);
    assign ena_hundreds = (ones == 4'd9) && (tens == 4'd9);

    // Split the counter into four BCD digits
    assign ones = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end
        else begin
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                if (tens == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (hundreds == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (thousands == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end
                        else begin
                            q[15:12] <= thousands + 4'd1;
                        end
                    end
                    else begin
                        q[11:8] <= hundreds + 4'd1;
                    end
                end
                else begin
                    q[7:4] <= tens + 4'd1;
                end
            end
            else begin
                q[3:0] <= ones + 4'd1;
            end
        end
    end

endmodule
