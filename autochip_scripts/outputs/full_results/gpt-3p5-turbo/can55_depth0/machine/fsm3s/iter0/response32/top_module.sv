module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
    
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'd0; // A state
    end else begin
        case (state)
            2'b00: begin // A state
                if (in) begin
                    state <= 2'b01; // B state
                end else begin
                    state <= 2'b00; // A state
                end
            end
            
            2'b01: begin // B state
                if (in) begin
                    state <= 2'b01; // B state
                end else begin
                    state <= 2'b10; // C state
                end
            end
            
            2'b10: begin // C state
                if (in) begin
                    state <= 2'b11; // D state
                end else begin
                    state <= 2'b00; // A state
                end
            end
            
			2'b11: begin // D state
                if (in) begin
                    state <= 2'b01; // B state
                end else begin
                    state <= 2'b10; // C state
                end
            end
        endcase
    end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
