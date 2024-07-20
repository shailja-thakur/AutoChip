module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] ones, tens, hundreds, thousands;
    wire ena_ones, ena_tens, ena_hundreds;

    // Assign outputs
    assign q = {thousands, hundreds, tens, ones};
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (ena[1] & (tens == 4'd9));
    assign ena[3] = (ena[2] & (hundreds == 4'd9));

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            // Ones digit logic
            if (ena[1] && (ones == 4'd9)) begin
                q[3:0] <= 4'd0;
            end else begin
                q[3:0] <= ones + 4'd1;
            end
            
            // Tens digit logic
            if (ena[2] && (tens == 4'd9)) begin
                q[7:4] <= 4'd0;
            end else if (ena[1] && (ones == 4'd9)) begin
                q[7:4] <= tens + 4'd1;
            end
            
            // Hundreds digit logic
            if (ena[3] && (hundreds == 4'd9)) begin
                q[11:8] <= 4'd0;
            end else if (ena[2] && (tens == 4'd9)) begin
                q[11:8] <= hundreds + 4'd1;
            end
            
            // Thousands digit logic
            if (ena[3] && (hundreds == 4'd9)) begin
                q[15:12] <= thousands + 4'd1;
            end
        end
    end
endmodule
