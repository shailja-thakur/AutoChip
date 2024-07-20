module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b1;
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        2'b00: begin
            if (in)
                next_state <= 2'b00; // State A transitions to itself if 'in' is high
            else
                next_state <= 2'b01; // State A transitions to state B if 'in' is low
        end
        2'b01: begin
            if (in)
                next_state <= 2'b01; // State B transitions to itself if 'in' is high
            else
                next_state <= 2'b00; // State B transitions to state A if 'in' is low
        end
    endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // 'out' is high when the state is B, low otherwise

endmodule
