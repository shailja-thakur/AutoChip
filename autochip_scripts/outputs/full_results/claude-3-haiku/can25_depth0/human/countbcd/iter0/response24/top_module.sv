module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the states for the counter
localparam ONES = 4'b0000;
localparam TENS = 4'b0100;
localparam HUNDREDS = 4'b1000;
localparam THOUSANDS = 4'b1100;

// Define the enable signals
assign ena[1] = (q[3:0] == ONES);
assign ena[2] = (q[7:4] == TENS);
assign ena[3] = (q[11:8] == HUNDREDS);

// Counter logic
always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Increment the counter
        if (q[3:0] == ONES) begin
            q[3:0] <= 0;
            if (q[7:4] == TENS) begin
                q[7:4] <= 0;
                if (q[11:8] == HUNDREDS) begin
                    q[11:8] <= 0;
                    if (q[15:12] == THOUSANDS) begin
                        q[15:12] <= 0;
                    end
                    else begin
                        q[15:12] <= q[15:12] + 1;
                    end
                end
                else begin
                    q[11:8] <= q[11:8] + 1;
                end
            end
            else begin
                q[7:4] <= q[7:4] + 1;
            end
        end
        else begin
            q[3:0] <= q[3:0] + 1;
        end
    end
end

endmodule
