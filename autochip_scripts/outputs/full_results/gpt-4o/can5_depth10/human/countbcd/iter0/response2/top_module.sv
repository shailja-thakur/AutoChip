module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Ones place
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                ena[1] <= 1'b1; // Enable tens place
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena[1] <= 1'b0;
            end

            // Tens place
            if (ena[1] && q[7:4] == 4'b1001) begin
                q[7:4] <= 4'b0000;
                ena[2] <= 1'b1; // Enable hundreds place
            end else if (ena[1]) begin
                q[7:4] <= q[7:4] + 1;
                ena[2] <= 1'b0;
            end

            // Hundreds place
            if (ena[2] && q[11:8] == 4'b1001) begin
                q[11:8] <= 4'b0000;
                ena[3] <= 1'b1; // Enable thousands place
            end else if (ena[2]) begin
                q[11:8] <= q[11:8] + 1;
                ena[3] <= 1'b0;
            end

            // Thousands place
            if (ena[3] && q[15:12] == 4'b1001) begin
                q[15:12] <= 4'b0000;
            end else if (ena[3]) begin
                q[15:12] <= q[15:12] + 1;
            end
        end
    end
endmodule
