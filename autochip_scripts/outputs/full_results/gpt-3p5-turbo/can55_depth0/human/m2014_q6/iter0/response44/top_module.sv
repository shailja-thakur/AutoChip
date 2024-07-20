module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // initial state is A
        else begin
            case (state)
                3'b000: // state A
                    if (w)
                        state <= 3'b000; // transition to A
                    else
                        state <= 3'b001; // transition to B
                3'b001: // state B
                    if (w)
                        state <= 3'b010; // transition to D
                    else
                        state <= 3'b011; // transition to C
                3'b010: // state C
                    if (w)
                        state <= 3'b010; // transition to C
                    else
                        state <= 3'b010; // transition to C
                3'b011: // state D
                    if (w)
                        state <= 3'b100; // transition to F
                    else
                        state <= 3'b000; // transition to A
                3'b100: // state E
                    if (w)
                        state <= 3'b100; // transition to E
                    else
                        state <= 3'b011; // transition to D
                3'b101: // state F
                    if (w)
                        state <= 3'b011; // transition to C
                    else
                        state <= 3'b011; // transition to C
                default:
                    state <= 3'b000;
            endcase
        end
    end
    
    assign z = (state == 3'b101);
    
endmodule
