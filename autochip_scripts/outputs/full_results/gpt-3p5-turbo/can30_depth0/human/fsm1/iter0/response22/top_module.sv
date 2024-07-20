module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 2'b01;  // state B
    end else begin
        case (state)
            2'b00: begin  // state A
                if (in == 1) begin
                    state <= 2'b00;  // stay in state A
                end else begin
                    state <= 2'b01;  // go to state B
                end
            end
            2'b01: begin  // state B
                if (in == 1) begin
                    state <= 2'b01;  // stay in state B
                end else begin
                    state <= 2'b00;  // go to state A
                end
            end
            default: state <= 2'b01;  // default to state B
        endcase
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
