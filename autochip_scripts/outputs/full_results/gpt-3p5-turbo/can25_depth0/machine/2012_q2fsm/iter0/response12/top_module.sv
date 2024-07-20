module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
   
    always @(posedge clk or posedge reset) begin
        if (reset == 1)
            state <= 3'b000; // initial state is A
        else begin
            case(state)
                3'b000:   // state A
                    if (w == 1) state <= 3'b001;  // state transitions from A to B
                    else state <= 3'b000;  // state remains A
                3'b001:   // state B
                    if (w == 1) state <= 3'b010;  // state transitions from B to C
                    else state <= 3'b100;  // state transitions from B to D
                3'b010:   // state C
                    if (w == 1) state <= 3'b110;  // state transitions from C to E
                    else state <= 3'b100;  // state transitions from C to D
                3'b011:   // state D
                    if (w == 1) state <= 3'b111;  // state transitions from D to F
                    else state <= 3'b000;  // state transitions from D to A
                3'b100:   // state E
                    if (w == 1) state <= 3'b100;  // state remains E
                    else state <= 3'b011;  // state transitions from E to D
                3'b111:   // state F
                    if (w == 1) state <= 3'b010;  // state transitions from F to C
                    else state <= 3'b011;  // state transitions from F to D
                default:
                    state <= 3'b000;  // default to state A
            endcase
        end
    end
   
    assign z = (state == 3'b100) || (state == 3'b111);  // output z is 1 when state is E or F

endmodule
