module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Output equations
    assign out1 = (state[6] == 1'b1 && state[9] == 1'b0) ? 1'b1 :
                  (state[4] == 1'b1 && state[9] == 1'b0) ? 1'b1 :
                  (state[9] == 1'b1 && state[5] == 1'b1 && in == 1'b0) ? 1'b1 :
                  1'b0;
    
    assign out2 = (state[9] == 1'b1 && state[7] == 1'b1) ? 1'b1 :
                  (state[9] == 1'b1 && state[8] == 1'b0) ? 1'b0 :
                  1'b0;

    // State transition equations
    always @* begin
        case (state)
            10'b001 && in: next_state = 10'b010;
            10'b010 && ~in: next_state = 10'b001;
            10'b010 && in: next_state = 10'b111;
            10'b011 && in: next_state = 10'b111;
            10'b011 && ~in: next_state = 10'b100;
            10'b100 && in: next_state = 10'b000;
            10'b100 && ~in: next_state = 10'b101;
            10'b101 && in: next_state = 10'b110;
            10'b101 && ~in: next_state = 10'b000;
            10'b110 && in: next_state = 10'b001;
            10'b110 && ~in: next_state = 10'b000;
            10'b111 && in: next_state = 10'b001;
            10'b111 && ~in: next_state = 10'b110;
            default: next_state = 10'b000;
        endcase
    end

endmodule
