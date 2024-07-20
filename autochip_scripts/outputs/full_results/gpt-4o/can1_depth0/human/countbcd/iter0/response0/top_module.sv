module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    reg [3:0] digit0, digit1, digit2, digit3;

    // Enable signals for incrementing the next higher digit
    assign ena[1] = (digit0 == 4'd9);
    assign ena[2] = (digit1 == 4'd9) && ena[1];
    assign ena[3] = (digit2 == 4'd9) && ena[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end else begin
            // Increment the ones digit
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
                if (digit1 == 4'd9) begin
                    digit1 <= 4'd0;
                    if (digit2 == 4'd9) begin
                        digit2 <= 4'd0;
                        if (digit3 == 4'd9) begin
                            digit3 <= 4'd0;
                        end else begin
                            digit3 <= digit3 + 4'd1;
                        end
                    end else begin
                        digit2 <= digit2 + 4'd1;
                    end
                end else begin
                    digit1 <= digit1 + 4'd1;
                end
            end else begin
                digit0 <= digit0 + 4'd1;
            end
        end
    end

    // Combine the digits into the output q
    always @(*) begin
        q = {digit3, digit2, digit1, digit0};
    end

endmodule
