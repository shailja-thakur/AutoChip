module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to state A
    else
        state <= next_state; // Transition to next state
end

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (x == 1) ? 2'b01 : 2'b00;
            z = (x == 1) ? 1'b1 : 1'b0;
        end
        
        2'b01: begin // State B
            next_state = (x == 0) ? 2'b01 : 2'b10;
            z = (x == 0) ? 1'b1 : 1'b0;
        end
        
        2'b10: begin // State B
            next_state = 2'b10;
            z = 1'b0;
        end
    endcase
end

endmodule
