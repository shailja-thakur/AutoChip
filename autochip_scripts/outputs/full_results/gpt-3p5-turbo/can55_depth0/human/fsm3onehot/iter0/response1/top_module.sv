module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @*
begin
    case(state)
        4'b0001: // State A
            if(in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0001; // Next state A
        4'b0010: // State B
            if(in)
                next_state = 4'b0010; // Next state B
            else
                next_state = 4'b0100; // Next state C
        4'b0100: // State C
            if(in)
                next_state = 4'b0001; // Next state A
            else
                next_state = 4'b1000; // Next state D
        4'b1000: // State D
            if(in)
                next_state = 4'b0100; // Next state C
            else
                next_state = 4'b0010; // Next state B
    endcase
end

// Output logic
always @(state)
begin
    case(state)
        4'b0001, 4'b0010, 4'b0100: // States A, B, C
            out = 1'b0;
        4'b1000: // State D
            out = 1'b1;
    endcase
end

endmodule
