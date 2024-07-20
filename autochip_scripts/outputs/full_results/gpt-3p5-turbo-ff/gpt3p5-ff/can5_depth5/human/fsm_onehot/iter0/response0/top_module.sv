module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // State transition logic
    always @(*)
    begin
        case(state)
            10'b0000000001: next_state = 10'b0000000001;
            10'b0000000010: next_state = 10'b0000000100;
            10'b0000000100: next_state = 10'b0000000001;
            10'b0000001000: next_state = 10'b0000001000;
            10'b0000010000: next_state = 10'b0000000001;
            10'b0000100000: next_state = 10'b0000010000;
            10'b0001000000: next_state = 10'b0000000001;
            10'b0010000000: next_state = 10'b0000100000;
            10'b0100000000: next_state = 10'b0000000001;
            10'b1000000000: next_state = 10'b0000000010;
        endcase
    end
    
    // Output logic
    always @(*)
    begin
        case(state)
            10'b0000000001: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0000000010: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0000000100: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0000001000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0000010000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0000100000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0001000000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0010000000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b0100000000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
            10'b1000000000: begin
                                out1 = 1'b0;
                                out2 = 1'b0;
                            end
        endcase
    end
endmodule
