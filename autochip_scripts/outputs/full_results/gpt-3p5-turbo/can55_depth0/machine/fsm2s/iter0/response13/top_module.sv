module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
	
reg [1:0] state; // Two-state variable to hold the current state
	
always @(posedge clk) begin
    if (reset == 1'b1) // If the reset input is high
        state <= 2'b0; // Set the state to A
    else begin // If the reset input is low
        if (state == 2'b00) // If the current state is A
            state <= (j == 1'b1) ? 2'b1 : 2'b0; // Set the next state based on input j
        else // If the current state is B
            state <= (k == 1'b1) ? 2'b0 : 2'b1; // Set the next state based on input k
    end
end
	
assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when the state is B, else low
	
endmodule
