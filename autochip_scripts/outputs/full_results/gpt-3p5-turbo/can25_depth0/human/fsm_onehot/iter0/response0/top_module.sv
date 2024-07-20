module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Output declarations
    wire out1_wire, out2_wire;

    // State transition logic
    always @(*)
    begin
        case(state)
            // S0
            10'b0000000001: begin
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S1
            10'b0000000010: begin
                if (in == 1)
                    next_state = 10'b0000000100; // S2
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S2
            10'b0000000100: begin
                if (in == 1)
                    next_state = 10'b0000001000; // S4
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S3
            10'b0000001000: begin
                if (in == 1)
                    next_state = 10'b0000010000; // S8
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S4
            10'b0000010000: begin
                if (in == 1)
                    next_state = 10'b0000100000; // S9
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S5
            10'b0000100000: begin
                if (in == 1)
                    next_state = 10'b0000000100; // S2
                else if (in == 0)
                    next_state = 10'b0000001000; // S4
            end
            // S6
            10'b0001000000: begin
                if (in == 1)
                    next_state = 10'b0010000000; // S6
                else if (in == 0)
                    next_state = 10'b0011000000; // S7
            end
            // S7
            10'b0010000000: begin
                if (in == 1)
                    next_state = 10'b0010000010; // S7
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S8
            10'b0100000000: begin
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            // S9
            10'b1000000000: begin
                if (in == 1)
                    next_state = 10'b0000000010; // S1
                else if (in == 0)
                    next_state = 10'b0000000001; // S0
            end
            default: next_state = 10'b0000000000; // Invalid state
        endcase
    end

    // Output logic
    always @(*)
    begin
        case(state)
            // S0
            10'b0000000001: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S1
            10'b0000000010: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S2
            10'b0000000100: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S3
            10'b0000001000: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S4
            10'b0000010000: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S5
            10'b0000100000: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S6
            10'b0001000000: begin
                out1_wire = 0;
                out2_wire = 0;
            end
            // S7
            10'b0010000000: begin
                out1_wire = 0;
                out2_wire = 1;
            end
            // S8
            10'b0100000000: begin
                out1_wire = 1;
                out2_wire = 0;
            end
            // S9
            10'b1000000000: begin
                out1_wire = 1;
                out2_wire = 1;
            end
            default: begin
                out1_wire = 0;
                out2_wire = 0;
            end
        endcase
    end

    // Assign wire outputs to module outputs
    assign out1 = out1_wire;
    assign out2 = out2_wire;

endmodule
