module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Counter logic
always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment ones digit
        if (q[3:0] == 4'd9) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'b1; // Ones digit reached 9, enable increment of tens digit
        end
        else begin
            q[3:0] <= q[3:0] + 1'd1;
            ena[1] <= 1'b0;
        end

        // Increment tens digit
        if (q[7:4] == 4'd9 && ena[1]) begin
            q[7:4] <= 4'd0;
            ena[2] <= 1'b1; // Tens digit reached 9, enable increment of hundreds digit
        end
        else if (ena[1]) begin
            q[7:4] <= q[7:4] + 1'd1;
            ena[2] <= 1'b0;
        end

        // Increment hundreds digit
        if (q[11:8] == 4'd9 && ena[2]) begin
            q[11:8] <= 4'd0;
            ena[3] <= 1'b1; // Hundreds digit reached 9, enable increment of thousands digit
        end
        else if (ena[2]) begin
            q[11:8] <= q[11:8] + 1'd1;
            ena[3] <= 1'b0;
        end

        // Increment thousands digit
        if (q[15:12] == 4'd9 && ena[3]) begin
            q[15:12] <= 4'd0;
        end
        else if (ena[3]) begin
            q[15:12] <= q[15:12] + 1'd1;
        end
    end
end

endmodule
