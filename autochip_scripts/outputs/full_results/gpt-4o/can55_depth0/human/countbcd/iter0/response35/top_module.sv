module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Counter enable for each digit
    assign ena[1] = (q[3:0] == 4'd9);         // Enable for tens digit
    assign ena[2] = ena[1] & (q[7:4] == 4'd9); // Enable for hundreds digit
    assign ena[3] = ena[2] & (q[11:8] == 4'd9); // Enable for thousands digit

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            // Ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                // Tens digit
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    // Hundreds digit
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        // Thousands digit
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= q[15:12] + 1'b1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1'b1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1'b1;
                end
            end else begin
                q[3:0] <= q[3:0] + 1'b1;
            end
        end
    end
endmodule
