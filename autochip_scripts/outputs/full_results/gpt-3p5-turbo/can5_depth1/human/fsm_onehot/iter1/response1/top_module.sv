module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    // Assign next_state based on current state and input
    always @*
    begin
        case(state)
            10'd0:   next_state = in ? 10'b0000000010 : 10'b0000000001;
            10'd1:   next_state = in ? 10'b0000000100 : 10'b0000000001;
            10'd2:   next_state = in ? 10'b0000000001 : 10'b0000000100;
            10'd3:   next_state = in ? 10'b0000000100 : 10'b0000001000;
            10'd4:   next_state = in ? 10'b0000001000 : 10'b0000000001;
            10'd5:   next_state = in ? 10'b0000001000 : 10'b0000010000;
            10'd6:   next_state = in ? 10'b0000010000 : 10'b0000100000;
            10'd7:   next_state = in ? 10'b0000000001 : 10'b0000100000;
            10'd8:   next_state = in ? 10'b0000000100 : 10'b0000000010;
            10'd9:   next_state = in ? 10'b0000000001 : 10'b0000000010;
            default: next_state = 10'd0;
        endcase
    end
   
    // Assign outputs based on current state
    always @*
    begin
        case(state)
            10'd0:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd1:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd2:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd3:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd4:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd5:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd6:   begin out1 = 1'b0; out2 = 1'b0; end
            10'd7:   begin out1 = 1'b0; out2 = 1'b1; end
            10'd8:   begin out1 = 1'b1; out2 = 1'b0; end
            10'd9:   begin out1 = 1'b1; out2 = 1'b1; end
            default: begin out1 = 1'b0; out2 = 1'b0; end
        endcase
    end
    
endmodule
