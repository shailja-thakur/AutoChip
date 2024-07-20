module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] ones, tens, hundreds, thousands;
    reg [3:0] ones_next, tens_next, hundreds_next, thousands_next;

    assign ones = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];

    assign ena[1] = (ones == 4'd9);
    assign ena[2] = ena[1] && (tens == 4'd9);
    assign ena[3] = ena[2] && (hundreds == 4'd9);

    always @(*) begin
        // Modulo 10 counters increment logic
        if (ones == 4'd9) ones_next = 4'd0;
        else ones_next = ones + 4'd1;

        if (tens == 4'd9 && ena[1]) tens_next = 4'd0;
        else if (ena[1]) tens_next = tens + 4'd1;
        else tens_next = tens;

        if (hundreds == 4'd9 && ena[2]) hundreds_next = 4'd0;
        else if (ena[2]) hundreds_next = hundreds + 4'd1;
        else hundreds_next = hundreds;

        if (thousands == 4'd9 && ena[3]) thousands_next = 4'd0;
        else if (ena[3]) thousands_next = thousands + 4'd1;
        else thousands_next = thousands;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            q[3:0] <= ones_next;
            q[7:4] <= tens_next;
            q[11:8] <= hundreds_next;
            q[15:12] <= thousands_next;
        end
    end

endmodule
