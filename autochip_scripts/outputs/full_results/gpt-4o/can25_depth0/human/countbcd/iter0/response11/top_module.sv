module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
    );

    wire [3:0] ones, tens, hundreds, thousands;
    reg one_carry, ten_carry, hundred_carry, thousand_carry;
    
    assign ones     = q[3:0];
    assign tens     = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];
    
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (tens == 4'd9) && ena[1];
    assign ena[3] = (hundreds == 4'd9) && ena[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            // Increment the ones place
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                one_carry <= 1'b1;
            end
            else begin
                q[3:0] <= ones + 4'd1;
                one_carry <= 1'b0;
            end
            
            // Increment the tens place
            if (one_carry) begin
                if (tens == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ten_carry <= 1'b1;
                end
                else begin
                    q[7:4] <= tens + 4'd1;
                    ten_carry <= 1'b0;
                end
            end

            // Increment the hundreds place
            if (ten_carry) begin
                if (hundreds == 4'd9) begin
                    q[11:8] <= 4'd0;
                    hundred_carry <= 1'b1;
                end
                else begin
                    q[11:8] <= hundreds + 4'd1;
                    hundred_carry <= 1'b0;
                end
            end

            // Increment the thousands place
            if (hundred_carry) begin
                if (thousands == 4'd9) begin
                    q[15:12] <= 4'd0;
                end
                else begin
                    q[15:12] <= thousands + 4'd1;
                end
            end
        end
    end
endmodule
