module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
	
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initial state is A
    end else begin
        case (state)
            3'b000: // State A
                begin
                    if (w) begin
                        state <= 3'b001; // State transition A to B
                    end else begin
                        state <= 3'b000; // State transition A to A
                    end
                end
            3'b001: // State B
                begin
                    if (w) begin
                        state <= 3'b010; // State transition B to C
                    end else begin
                        state <= 3'b100; // State transition B to D
                    end
                end
            3'b010: // State C
                begin
                    if (w) begin
                        state <= 3'b100; // State transition C to E
                    end else begin
                        state <= 3'b110; // State transition C to D
                    end
                end
            3'b100: // State D
                begin
                    if (w) begin
                        state <= 3'b111; // State transition D to F
                    end else begin
                        state <= 3'b000; // State transition D to A
                    end
                end
            3'b110: // State E
                begin
                    if (w) begin
                        state <= 3'b111; // State transition E to E
                    end else begin
                        state <= 3'b100; // State transition E to D
                    end
                end
            3'b111: // State F
                begin
                    if (w) begin
                        state <= 3'b010; // State transition F to C
                    end else begin
                        state <= 3'b100; // State transition F to D
                    end
                end
        endcase
    end
end
	
assign z = (state == 3'b110) | (state == 3'b111);

endmodule
