module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Set initial state
    else begin
        case (state)
            3'b000: 
                if (w)
                    state <= 3'b001; // Transition from A to B
                else
                    state <= 3'b000; // Transition from A to A
            3'b001:
                if (w)
                    state <= 3'b010; // Transition from B to C
                else
                    state <= 3'b100; // Transition from B to D
            3'b010:
                if (w)
                    state <= 3'b110; // Transition from C to E
                else
                    state <= 3'b100; // Transition from C to D
            3'b011:
                state <= 3'b000; // Transition from D to A
            3'b100:
                if (w)
                    state <= 3'b010; // Transition from D to C
                else
                    state <= 3'b011; // Transition from D to E
            3'b101:
                state <= 3'b100; // Transition from E to D
            3'b110:
                if (w)
                    state <= 3'b110; // Transition from E to E
                else
                    state <= 3'b011; // Transition from E to D
            3'b111:
                state <= 3'b010; // Transition from F to C
        endcase
    end
end

assign z = (state == 3'b110) || (state == 3'b111); // Set z to 1 when state is E or F

endmodule
