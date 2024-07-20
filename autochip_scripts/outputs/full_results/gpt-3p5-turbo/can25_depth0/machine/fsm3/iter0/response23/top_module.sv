module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

// combinational logic for determining next state
always @ (state or in) begin
    case (state)
        2'b00: next_state = in ? 2'b01 : 2'b00; // state A
        2'b01: next_state = in ? 2'b01 : 2'b10; // state B
        2'b10: next_state = in ? 2'b11 : 2'b00; // state C
        2'b11: next_state = in ? 2'b01 : 2'b10; // state D
        default: next_state = 2'b00; // default to state A
    endcase
end

// sequential logic for updating state register
always @(posedge clk) begin
    if (areset) begin
        state <= 2'b00; // reset to state A
    end else begin
        state <= next_state;
    end
end

// assign output signal
assign out = state == 2'b11 ? 1'b1 : 1'b0;

endmodule
