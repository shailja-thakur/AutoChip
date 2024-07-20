module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    // Reset or clock positive edge handling
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;        // Reset the counter
            ena <= 3'b0;       // Reset enables
        end else begin
            // Handle ones digit (q[3:0])
            if (q[3:0] == 9) begin
                q[3:0] <= 0;
                ena[1] <= 1;
            end else begin
                q[3:0] <= q[3:0] + 1;
                ena[1] <= 0;
            end

            // Handle tens digit (q[7:4])
            if (ena[1]) begin
                if (q[7:4] == 9) begin
                    q[7:4] <= 0;
                    ena[2] <= 1;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    ena[2] <= 0;
                end
            end else begin
                ena[2] <= 0;
            end

            // Handle hundreds digit (q[11:8])
            if (ena[2]) begin
                if (q[11:8] == 9) begin
                    q[11:8] <= 0;
                    ena[3] <= 1;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    ena[3] <= 0;
                end
            end else begin
                ena[3] <= 0;
            end

            // Handle thousands digit (q[15:12])
            if (ena[3]) begin
                if (q[15:12] == 9) begin
                    q[15:12] <= 0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
