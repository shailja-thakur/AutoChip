module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire enable_ones, enable_tens, enable_hundreds;

    assign ena[1] = enable_ones;
    assign ena[2] = enable_tens;
    assign ena[3] = enable_hundreds;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            // Ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                enable_ones <= 1;
            end else begin
                q[3:0] <= q[3:0] + 1;
                enable_ones <= 0;
            end

            // Tens digit
            if (enable_ones) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    enable_tens <= 1;
                end else begin
                    q[7:4] <= q[7:4] + 1;
                    enable_tens <= 0;
                end
            end

            // Hundreds digit
            if (enable_tens) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    enable_hundreds <= 1;
                end else begin
                    q[11:8] <= q[11:8] + 1;
                    enable_hundreds <= 0;
                end
            end

            // Thousands digit
            if (enable_hundreds) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 1;
                end
            end
        end
    end
endmodule
