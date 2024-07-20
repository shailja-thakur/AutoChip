module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000: // A
                if (w)
                    state <= 3'b001; // A
                else
                    state <= 3'b010; // B
            3'b001: // A
                if (w)
                    state <= 3'b001; // A
                else
                    state <= 3'b010; // B
            3'b010: // B
                if (w)
                    state <= 3'b011; // D
                else
                    state <= 3'b100; // C
            3'b011: // D
                if (w)
                    state <= 3'b001; // A
                else
                    state <= 3'b101; // F
            3'b100: // C
                if (w)
                    state <= 3'b110; // E
                else
                    state <= 3'b010; // B
            3'b101: // F
                if (w)
                    state <= 3'b100; // C
                else
                    state <= 3'b011; // D
            3'b110: // E
                if (w)
                    state <= 3'b110; // E
                else
                    state <= 3'b111; // Invalid state
            3'b111: // Invalid state
                state <= 3'b000; // A
        endcase
    end
end

always @(state) begin
    case (state)
        3'b000: // A
            z = 1'b0;
        3'b001: // A
            z = 1'b0;
        3'b010: // B
            z = 1'b0;
        3'b011: // D
            z = 1'b0;
        3'b100: // C
            z = 1'b1;
        3'b101: // F
            z = 1'b1;
        3'b110: // E
            z = 1'b1;
        3'b111: // Invalid state
            z = 1'b0;
    endcase
end

endmodule
