module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: // State A
                if (w) begin
                    state <= 3'b001; // State B
                end else begin
                    state <= 3'b000; // State A
                end
            3'b001: // State B
                if (w) begin
                    state <= 3'b010; // State C
                end else begin
                    state <= 3'b100; // State D
                end
            3'b010: // State C
                if (w) begin
                    state <= 3'b011; // State E
                end else begin
                    state <= 3'b100; // State D
                end
            3'b011: // State E
                if (w) begin
                    state <= 3'b011; // State E
                end else begin
                    state <= 3'b100; // State D
                end
            3'b100: // State D
                if (w) begin
                    state <= 3'b110; // State F
                end else begin
                    state <= 3'b000; // State A
                end
            3'b110: // State F
                if (w) begin
                    state <= 3'b010; // State C
                end else begin
                    state <= 3'b100; // State D
                end
        endcase
    end
end

assign z = (state == 3'b011) || (state == 3'b110);

endmodule
