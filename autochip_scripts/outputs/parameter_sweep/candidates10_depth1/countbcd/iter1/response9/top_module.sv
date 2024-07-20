module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Declare internal signal for the enable signals of the upper three digits
    reg [2:0] ena_internal;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena_internal <= 3'b000;
        end else begin
            // Increment the ones digit
            if (ena_internal[0] && (q[3:0] != 4'b1001)) begin
                q[3:0] <= q[3:0] + 1;
            end

            // Increment the tens digit
            if (ena_internal[1] && (q[7:4] != 4'b1001)) begin
                q[7:4] <= q[7:4] + 1;
            end

            // Increment the hundreds digit
            if (ena_internal[2] && (q[11:8] != 4'b1001)) begin
                q[11:8] <= q[11:8] + 1;
            end

            // Increment the thousands digit
            if (q[15:12] != 4'b1001) begin
                q[15:12] <= q[15:12] + 1;
            end

            // Update the enable signals
            ena_internal <= {ena_internal[1:0], q[15]};
        end
    end

    // Assign the output enable signals
    assign ena = ena_internal;

endmodule
