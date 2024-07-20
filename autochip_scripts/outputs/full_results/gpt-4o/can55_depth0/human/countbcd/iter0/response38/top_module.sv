module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Split the q register into four BCD digits
    wire [3:0] ones  = q[3:0];
    wire [3:0] tens  = q[7:4];
    wire [3:0] hund  = q[11:8];
    wire [3:0] thous = q[15:12];
    
    // Enable signals for incrementing each BCD digit
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (tens == 4'd9) && ena[1];
    assign ena[3] = (hund == 4'd9) && ena[2];
    
    // Synchronous process to update the BCD digits
    always @(posedge clk) begin
        if (reset) begin
            q <= 16'd0; // Reset all BCD digits to 0
        end else begin
            // Increment the BCD digits with carry
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                if (tens == 4'd9) begin
                    q[7:4] <= 4'd0;
                    if (hund == 4'd9) begin
                        q[11:8] <= 4'd0;
                        if (thous == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= thous + 1;
                        end
                    end else begin
                        q[11:8] <= hund + 1;
                    end
                end else begin
                    q[7:4] <= tens + 1;
                end
            end else begin
                q[3:0] <= ones + 1;
            end
        end
    end
endmodule
