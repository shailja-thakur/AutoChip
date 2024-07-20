module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
);

// State transition logic
always @(*)
begin
    case (state)
        10'b1_000_000_000:
            if (in)
                next_state = 10'b0_010_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_010_000_000:
            if (in)
                next_state = 10'b1_001_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b1_001_000_000:
            if (in)
                next_state = 10'b0_010_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_010_000_000:
            if (in)
                next_state = 10'b1_100_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b1_100_000_000:
            if (in)
                next_state = 10'b0_010_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_010_000_000:
            if (in)
                next_state = 10'b0_000_100_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_000_100_000:
            if (in)
                next_state = 10'b1_000_010_000;
            else
                next_state = 10'b1_000_000_000;
        10'b1_000_010_000:
            if (in)
                next_state = 10'b0_010_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_010_000_000:
            if (in)
                next_state = 10'b1_000_000_100;
            else
                next_state = 10'b1_000_000_000;
        10'b1_000_000_100:
            if (in)
                next_state = 10'b0_010_000_000;
            else
                next_state = 10'b1_000_000_000;
        10'b0_010_000_000:
            if (in)
                next_state = 10'b0_000_000_010;
            else
                next_state = 10'b1_000_000_000;
        10'b0_000_000_010:
            if (in)
                next_state = 10'b0_001_000_100;
            else
                next_state = 10'b1_000_000_000;
        10'b0_001_000_100:
            if (in)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b1_000_000_010;
        default:
            next_state = 10'b1_000_000_000;
    endcase
end

// Output logic
assign out1 = (state == 10'b0_000_010_000 || state == 10'b0_000_000_010 || state == 10'b1_000_000_100 || state == 10'b0_001_000_100) ? 1'b1 : 1'b0;
assign out2 = (state == 10'b0_000_100_000 || state == 10'b0_000_000_010 || state == 10'b0_001_000_100 || state == 10'b1_000_000_010 || state == 10'b0_001_000_100) ? 1'b1 : 1'b0;

endmodule
