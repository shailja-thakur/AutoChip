module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
        z <= 0;
	end else begin
		state <= next_state;
        case (state)
            2'b00: begin
                if (s)
                    next_state <= 2'b01;
                else
                    next_state <= 2'b00;
                z <= 0;
            end

            2'b01: begin
                if (w)
                    next_state <= 2'b10;
                else
                    next_state <= 2'b01;
                z <= 0;
            end

            2'b10: begin
                if (w) begin
                    next_state <= 2'b11;
                    z <= 0;
                end else begin
                    next_state <= 2'b01;
                    z <= 0;
                end
            end

            2'b11: begin
                if (w) begin
                    next_state <= 2'b11;
                    z <= 1;
                end else begin
                    next_state <= 2'b01;
                    z <= 0;
                end
            end

            default: next_state <= 2'b00;
        endcase
	end
end

endmodule
