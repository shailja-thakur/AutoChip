module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);
    wire [3:0] dig0, dig1, dig2, dig3;
    assign dig0 = q[3:0];
    assign dig1 = q[7:4];
    assign dig2 = q[11:8];
    assign dig3 = q[15:12];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
            ena <= 3'b000;
        end else begin
            // Digit 0
            if (dig0 == 4'd9) begin
                q[3:0] <= 4'd0;
                q[7:4] <= q[7:4] + 4'd1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end

            // Enable for digit 1
            if (dig0 == 4'd9)
                ena[1] <= 1'b1;
            else
                ena[1] <= 1'b0;

            // Digit 1
            if (dig1 == 4'd9 && ena[1]) begin
                q[7:4] <= 4'd0;
                q[11:8] <= q[11:8] + 4'd1;
            end else if (ena[1]) begin
                q[7:4] <= q[7:4] + 4'd1;
            end

            // Enable for digit 2
            if (dig1 == 4'd9 && ena[1])
                ena[2] <= 1'b1;
            else
                ena[2] <= 1'b0;

            // Digit 2
            if (dig2 == 4'd9 && ena[2]) begin
                q[11:8] <= 4'd0;
                q[15:12] <= q[15:12] + 4'd1;
            end else if (ena[2]) begin
                q[11:8] <= q[11:8] + 4'd1;
            end

            // Enable for digit 3
            if (dig2 == 4'd9 && ena[2])
                ena[3] <= 1'b1;
            else
                ena[3] <= 1'b0;

            // Digit 3
            if (dig3 == 4'd9 && ena[3]) begin
                q[15:12] <= 4'd0;
            end else if (ena[3]) begin
                q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end

endmodule
