module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b10; // reset state B
    else begin
        case (state)
            2'b00: begin // state A
                if (in)
                    state <= 2'b01; // transition to A
                else
                    state <= 2'b10; // transition to B
            end
            2'b01: begin // state B
                if (in)
                    state <= 2'b01; // stay in B
                else
                    state <= 2'b10; // transition to B
            end
            default: state <= 2'b10; // reset state B
        endcase
    end
end

always @(state) begin
    case (state)
        2'b00: out <= 1'b0; // state A, out=0
        2'b01: out <= 1'b1; // state B, out=1
        default: out <= 1'b1; // reset state B, out=1
    endcase
end

endmodule
