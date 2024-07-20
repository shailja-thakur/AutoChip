module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the decimal digits
wire [3:0] ones = q[3:0];
wire [3:0] tens = q[7:4];
wire [3:0] hundreds = q[11:8];
wire [3:0] thousands = q[15:12];

// Increment the upper digits when the lower digits roll over
assign ena[1] = (ones == 4'b1001);
assign ena[2] = (tens == 4'b1001) & ena[1];
assign ena[3] = (hundreds == 4'b1001) & ena[2];

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the counter
        if (ones == 4'b1001) begin
            q[3:0] <= 4'b0000;
            if (tens == 4'b1001) begin
                q[7:4] <= 4'b0000;
                if (hundreds == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    if (thousands == 4'b1001) begin
                        q[15:12] <= 4'b0000;
                    end
                    else begin
                        q[15:12] <= q[15:12] + 4'b0001;
                    end
                end
                else begin
                    q[11:8] <= q[11:8] + 4'b0001;
                end
            end
            else begin
                q[7:4] <= q[7:4] + 4'b0001;
            end
        end
        else begin
            q[3:0] <= q[3:0] + 4'b0001;
        end
    end
end

endmodule
