module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @ (state, in)
begin
    case(state)
        4'b0001: // A
            if(in == 1'b0)
                next_state = 4'b0001; // A
            else if(in == 1'b1)
                next_state = 4'b0010; // B
        4'b0010: // B
            if(in == 1'b0)
                next_state = 4'b0100; // C
            else if(in == 1'b1)
                next_state = 4'b0010; // B
        4'b0100: // C
            if(in == 1'b0)
                next_state = 4'b0001; // A
            else if(in == 1'b1)
                next_state = 4'b1000; // D
        4'b1000: // D
            if(in == 1'b0)
                next_state = 4'b0100; // C
            else if(in == 1'b1)
                next_state = 4'b0010; // B
        default:
            next_state = 4'bxxxx; // Undefined state
    endcase
end

// Output logic
always @ (state)
begin
    case(state)
        4'b1000: // D
            out = 1'b1;
        default:
            out = 1'b0;
    endcase
end

endmodule
