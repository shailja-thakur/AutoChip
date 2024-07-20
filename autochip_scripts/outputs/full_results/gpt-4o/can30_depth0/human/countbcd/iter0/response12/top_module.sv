module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    reg [3:0] digit0, digit1, digit2, digit3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end
        else begin
            // Ones place increment
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
                // Tens place increment
                if (digit1 == 4'd9) begin
                    digit1 <= 4'd0;
                    // Hundreds place increment
                    if (digit2 == 4'd9) begin
                        digit2 <= 4'd0;
                        // Thousands place increment
                        if (digit3 == 4'd9) begin
                            digit3 <= 4'd0;
                        end
                        else begin
                            digit3 <= digit3 + 4'd1;
                        end
                    end
                    else begin
                        digit2 <= digit2 + 4'd1;
                    end
                end
                else begin
                    digit1 <= digit1 + 4'd1;
                end
            end
            else begin
                digit0 <= digit0 + 4'd1;
            end
        end
    end

    assign ena[1] = (digit0 == 4'd0) ? 1'b1 : 1'b0;
    assign ena[2] = (digit1 == 4'd0 && digit0 == 4'd0) ? 1'b1 : 1'b0;
    assign ena[3] = (digit2 == 4'd0 && digit1 == 4'd0 && digit0 == 4'd0) ? 1'b1 : 1'b0;

    always @(*) begin
        q[3:0] = digit0;
        q[7:4] = digit1;
        q[11:8] = digit2;
        q[15:12] = digit3;
    end

endmodule
