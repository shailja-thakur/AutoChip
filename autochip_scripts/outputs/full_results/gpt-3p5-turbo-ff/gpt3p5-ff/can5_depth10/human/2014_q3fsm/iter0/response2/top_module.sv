module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        case(state)
            2'b00: begin // State A
                if (s) begin
                    state <= 2'b01;
                end
            end
            
            2'b01: begin // State B
                if (w == 2'b01) begin
                    state <= 2'b10;
                else if (w == 2'b11) begin
                    state <= 2'b11;
                end
            end
            
            2'b10: begin // State C
                if (w == 2'b01) begin
                    state <= 2'b11;
                end else if (w == 2'b00) begin
                    state <= 2'b00;
                end
            end
            
            2'b11: begin // State D
                if (w == 2'b00) begin
                    state <= 2'b00;
                end else if (w == 2'b01) begin
                    z <= 1;
                    state <= 2'b01;
                end
            end
        endcase
    end
end

endmodule
