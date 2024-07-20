module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Enable signal generation based on BCD logic
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9) & ena[1];
    assign ena[3] = (q[11:8] == 4'd9) & ena[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;  // Reset the counter to 0
        end else begin
            // Increment the ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;

                // Increment the tens digit
                if (q[7:4] == 4'd9)
                    q[7:4] <= 4'd0;
                else
                    q[7:4] <= q[7:4] + 4'd1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
            
            // Handle hundreds digit
            if (ena[1]) begin
                if (q[11:8] == 4'd9)
                    q[11:8] <= 4'd0;
                else
                    q[11:8] <= q[11:8] + 4'd1;
            end

            // Handle thousands digit
            if (ena[2]) begin
                if (q[15:12] == 4'd9)
                    q[15:12] <= 4'd0;
                else
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end
endmodule
