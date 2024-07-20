module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] ones = q[3:0];
    wire [3:0] tens = q[7:4];
    wire [3:0] hundreds = q[11:8];
    wire [3:0] thousands = q[15:12];
    
    assign ena[1] = ((ones == 4'd9) && !reset) ? 1'b1 : 1'b0;
    assign ena[2] = ((tens == 4'd9) && ena[1] && !reset) ? 1'b1 : 1'b0;
    assign ena[3] = ((hundreds == 4'd9) && ena[2] && !reset) ? 1'b1 : 1'b0;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end
        else begin
            // Ones place
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                // Tens place
                if (tens == 4'd9) begin
                    q[7:4] <= 4'd0;
                    // Hundreds place
                    if (hundreds == 4'd9) begin
                        q[11:8] <= 4'd0;
                        // Thousands place
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
