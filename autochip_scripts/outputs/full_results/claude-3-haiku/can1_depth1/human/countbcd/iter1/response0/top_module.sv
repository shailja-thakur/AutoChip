module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 16'b0;
        ena <= 3'b0;
    end
    else begin
        // Increment the ones digit
        q[3:0] <= (q[3:0] == 4'b1001) ? 4'b0000 : q[3:0] + 4'b0001;

        // Increment the tens digit when the ones digit overflows
        if (q[3:0] == 4'b1001) begin
            q[7:4] <= (q[7:4] == 4'b1001) ? 4'b0000 : q[7:4] + 4'b0001;
            ena[1] <= 1'b1;
        end
        else begin
            ena[1] <= 1'b0;
        end

        // Increment the hundreds digit when the tens digit overflows
        if (q[7:4] == 4'b1001) begin
            q[11:8] <= (q[11:8] == 4'b1001) ? 4'b0000 : q[11:8] + 4'b0001;
            ena[2] <= 1'b1;
        end
        else begin
            ena[2] <= 1'b0;
        end

        // Increment the thousands digit when the hundreds digit overflows
        if (q[11:8] == 4'b1001) begin
            q[15:12] <= (q[15:12] == 4'b1001) ? 4'b0000 : q[15:12] + 4'b0001;
            ena[3] <= 1'b1;
        end
        else begin
            ena[3] <= 1'b0;
        end
    end
end

endmodule
