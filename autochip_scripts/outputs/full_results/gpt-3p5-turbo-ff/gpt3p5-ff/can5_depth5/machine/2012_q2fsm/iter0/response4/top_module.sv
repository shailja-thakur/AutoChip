module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state; // 3-bit register to represent the states

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initializing the state machine to state A
        end else begin
            case (state)
                3'b000: if (w) state <= 3'b001; else state <= 3'b000; // State A transitions
                3'b001: if (w) state <= 3'b010; else state <= 3'b010; // State B transitions
                3'b010: if (w) state <= 3'b100; else state <= 3'b011; // State C transitions
                3'b011: if (w) state <= 3'b000; else state <= 3'b000; // State D transitions
                3'b100: if (w) state <= 3'b100; else state <= 3'b011; // State E transitions
                3'b101: if (w) state <= 3'b010; else state <= 3'b010; // State F transitions
            endcase
        end
    end

    assign z = (state == 3'b100) || (state == 3'b101); // Set z output to 1 when in state E or F

endmodule
