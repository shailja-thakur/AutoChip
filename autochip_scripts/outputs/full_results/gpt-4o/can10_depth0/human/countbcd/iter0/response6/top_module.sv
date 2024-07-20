module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

	// Declaration of enable signals
    wire [3:0] q0, q1, q2, q3;
    reg [3:0] d0, d1, d2, d3;
    
    // Assign enable signals based on the conditions for rolling over
    assign ena[1] = (q0 == 4'd9);   // Increment tens place when ones goes from 9 -> 0
    assign ena[2] = (q1 == 4'd9) && ena[1]; // Increment hundreds when tens goes from 9 -> 0 and ones from 9 -> 0
    assign ena[3] = (q2 == 4'd9) && ena[2]; // Increment thousands when hundreds from 9 -> 0
    
    // Always block for synchronous reset and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize all digits to zero on reset
            q <= 16'd0;
        end
        else begin
            // Least significant digit (ones place counter)
            if (q0 == 4'd9) begin
                q0 <= 4'd0;
            end
            else begin
                q0 <= q0 + 4'd1;
            end
            
            // Tens place counter
            if (ena[1]) begin
                if (q1 == 4'd9) begin
                    q1 <= 4'd0;
                end
                else begin
                    q1 <= q1 + 4'd1;
                end
            end
            
            // Hundreds place counter
            if (ena[2]) begin
                if (q2 == 4'd9) begin
                    q2 <= 4'd0;
                end
                else begin
                    q2 <= q2 + 4'd1;
                end
            end
            
            // Thousands place counter
            if (ena[3]) begin
                if (q3 == 4'd9) begin
                    q3 <= 4'd0;
                end
                else begin
                    q3 <= q3 + 4'd1;
                end
            end
            
            // Combine the digits into the full BCD number
            q <= {q3, q2, q1, q0};
        end
    end
endmodule
