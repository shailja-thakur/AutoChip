module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk) begin
    if (reset)
        state <= 2'b00; // state A
    else begin
        case (state)
            2'b00 : begin // state A
                if (in)
                    state <= 2'b01; // state B
                else
                    state <= 2'b00; // state A
            end
            2'b01 : begin // state B
                if (in)
                    state <= 2'b01; // state B
                else
                    state <= 2'b10; // state C
            end
            2'b10 : begin // state C
                if (in)
                    state <= 2'b11; // state D
                else
                    state <= 2'b00; // state A
            end
            2'b11 : begin // state D
                if (in)
                    state <= 2'b01; // state B
                else
                    state <= 2'b10; // state C
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 2'b11) // state D
        out <= 1;
    else
        out <= 0;
end

endmodule
