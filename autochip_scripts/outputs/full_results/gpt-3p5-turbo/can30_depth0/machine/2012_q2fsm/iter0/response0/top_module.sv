module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state
    else
        state <= next_state; // State transition
end

always @* begin
    case (state)
        3'b000: begin // State A
            if (w)
                next_state = 3'b001; // Next state B
            else
                next_state = 3'b000; // Next state A
        end
        3'b001: begin // State B
            if (w)
                next_state = 3'b010; // Next state C
            else
                next_state = 3'b011; // Next state D
        end
        3'b010: begin // State C
            if (w)
                next_state = 3'b100; // Next state E
            else
                next_state = 3'b011; // Next state D
        end
        3'b011: begin // State D
            if (w)
                next_state = 3'b111; // Next state F
            else
                next_state = 3'b000; // Next state A
        end
        3'b100: begin // State E
            if (w)
                next_state = 3'b100; // Next state E
            else
                next_state = 3'b011; // Next state D
        end
        3'b111: begin // State F
            if (w)
                next_state = 3'b010; // Next state C
            else
                next_state = 3'b011; // Next state D
        end
        default: next_state = 3'b000; // Default state
    endcase
end

assign z = (state == 3'b100) | (state == 3'b111); // Output condition

endmodule
