module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg[2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // Initial state is A
    else
        case (state)
            3'b000:  // A
                if (w)
                    state <= 3'b001;  // Transition to B
                else
                    state <= 3'b000;  // Remain in A
            3'b001:  // B
                if (w)
                    state <= 3'b010;  // Transition to C
                else
                    state <= 3'b100;  // Transition to D
            3'b010:  // C
                if (w)
                    state <= 3'b110;  // Transition to E
                else
                    state <= 3'b100;  // Transition to D
            3'b100:  // D
                if (w)
                    state <= 3'b111;  // Transition to F
                else
                    state <= 3'b000;  // Transition to A
            3'b110:  // E
                if (w)
                    state <= 3'b110;  // Remain in E
                else
                    state <= 3'b100;  // Transition to D
            3'b111:  // F
                if (w)
                    state <= 3'b011;  // Transition to C
                else
                    state <= 3'b100;  // Transition to D
        endcase
end

assign z = (state == 3'b110 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
