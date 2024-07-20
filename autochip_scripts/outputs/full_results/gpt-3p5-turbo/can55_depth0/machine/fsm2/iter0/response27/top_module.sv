module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

assign out = (state == 2'b10) ? 1'b1 : 1'b0; // Set out to high if state is B, otherwise low

always_comb begin
    // Determine next state based on current state and input values
    case (state)
        2'b00: // A
            next_state = (j == 1'b1) ? 2'b01 : 2'b00;
        2'b01: // B
            next_state = (k == 1'b1) ? 2'b00 : 2'b01;
        default:
            next_state = 2'b00;
    endcase
end

always @(posedge clk) begin
    // Update state based on areset and next_state
    if (areset == 1'b1)
        state <= 2'b00;
    else
        state <= next_state;
end

endmodule
