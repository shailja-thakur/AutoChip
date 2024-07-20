module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Assign next_state based on current state and input
    always @*
    begin
        case(state)
            10'b0000000000:   next_state = in ? 10'b0000000010 : 10'b0000000001;
            10'b0000000001:   next_state = in ? 10'b0000000100 : 10'b0000000001;
            10'b0000000010:   next_state = in ? 10'b0000000001 : 10'b0000000100;
            10'b0000000100:   next_state = in ? 10'b0000000100 : 10'b0000001000;
            10'b0000001000:   next_state = in ? 10'b0000001000 : 10'b0000000001;
            10'b0000010000:   next_state = in ? 10'b0000001000 : 10'b0000010000;
            10'b0000100000:   next_state = in ? 10'b0000010000 : 10'b0000100000;
            10'b0001000000:   next_state = in ? 10'b0000000001 : 10'b0000100000;
            10'b0010000000:   next_state = in ? 10'b0000000100 : 10'b0000000010;
            10'b0100000000:   next_state = in ? 10'b0000000001 : 10'b0000000010;
            default: next_state = 10'b0000000000;
        endcase
    end
   
    // Assign outputs based on current state
    always @*
    begin
        case(state)
            10'b0000000000:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000000001:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000000010:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000000100:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000001000:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000010000:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0000100000:   begin out1 = 1'b0; out2 = 1'b0; end
            10'b0001000000:   begin out1 = 1'b0; out2 = 1'b1; end
            10'b0010000000:   begin out1 = 1'b1; out2 = 1'b0; end
            10'b0100000000:   begin out1 = 1'b1; out2 = 1'b1; end
            default: begin out1 = 1'b0; out2 = 1'b0; end
        endcase
    end
    
endmodule
