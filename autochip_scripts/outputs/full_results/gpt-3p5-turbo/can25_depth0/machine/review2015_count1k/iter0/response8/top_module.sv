module top_module(
    input clk,
    input reset,
    output reg [9:0] q
    );
	
// Define a always block that triggers on the positive edge of the clock
always @(posedge clk)
begin
    // Check if the reset input is active
    if (reset == 1'b1)
    begin
        // If reset is active, reset the output register to 0
        q <= 10'd0;
    end
    else
    begin
        // If reset is not active, increment the output register by 1
        q <= q + 10'd1;
        
        // Check if the output register has reached 999
        if (q == 10'd999)
        begin
            // If the output register has reached 999, reset it to 0
            q <= 10'd0;
        end
    end
end

endmodule
