module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;  // Initial state is A
        else begin
            case (state)
                3'b000: begin  // state A
                    if (w)
                        state <= 3'b001;  // transition to state B
                    else
                        state <= 3'b000;  // stay in state A
                end
                3'b001: begin  // state B
                    if (w)
                        state <= 3'b010;  // transition to state C
                    else
                        state <= 3'b100;  // transition to state D
                end
                3'b010: begin  // state C
                    if (w)
                        state <= 3'b110;  // transition to state E
                    else
                        state <= 3'b100;  // transition to state D
                end
                3'b011: begin  // state D - alternate transition
                    state <= 3'b100;  // always transition to state D
                end
                3'b100: begin  // state D
                    if (w)
                        state <= 3'b111;  // transition to state F
                    else
                        state <= 3'b000;  // transition to state A
                end
                3'b101: begin  // state E - alternate transition
                    state <= 3'b010;  // always transition to state C
                end
                3'b110: begin  // state E
                    if (w)
                        state <= 3'b110;  // stay in state E
                    else
                        state <= 3'b100;  // transition to state D
                end
                3'b111: begin  // state F
                    if (w)
                        state <= 3'b011;  // transition to state D
                     else
                        state <= 3'b010;  // transition to state C
                end
            endcase
        end
    end
    
    // Assign output z based on state E or F
    assign z = (state == 3'b110 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
