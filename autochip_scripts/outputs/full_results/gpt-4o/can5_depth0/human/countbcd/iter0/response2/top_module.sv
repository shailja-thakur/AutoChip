module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

    // Enable signals for each BCD digit
    assign ena[1] = (q[3:0] == 4'd9);       // Enable tens digit when ones digit overflows
    assign ena[2] = ena[1] & (q[7:4] == 4'd9);  // Enable hundreds digit when tens digit overflows
    assign ena[3] = ena[2] & (q[11:8] == 4'd9); // Enable thousands digit when hundreds digit overflows

    // Synchronous process to update the BCD counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0; // Reset all digits to zero
        end else begin
            // Handle ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                // Handle tens digit
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    // Handle hundreds digit
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        // Handle thousands digit
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end

endmodule
