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
            z <= 0;
        end else begin
            case (state)
                2'b00: begin
                    if (s) begin
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    if (w) begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (w) begin
                        state <= 2'b11;
                    end
                end
                2'b11: begin
                    if (w) begin
                        z <= 1;
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                    end
                end
            endcase
        end
    end
endmodule
