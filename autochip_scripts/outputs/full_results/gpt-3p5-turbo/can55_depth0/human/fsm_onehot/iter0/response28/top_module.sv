module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    reg [9:0] next_state_temp;
    reg out1_temp;
    reg out2_temp;
    
    always @*
    begin
        case (state)
            10'b0000000001: begin
                next_state_temp = 10'b0000000001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0000000010: begin
                next_state_temp = 10'b0000000001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0000000100: begin
                next_state_temp = 10'b0000000001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0000001000: begin
                next_state_temp = 10'b0000000001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0000010000: begin
                next_state_temp = 10'b0000001000;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0000100000: begin
                next_state_temp = 10'b0000000110;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0001000000: begin
                next_state_temp = 10'b0000001001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0010000000: begin
                next_state_temp = 10'b0000000001;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b0100000000: begin
                next_state_temp = 10'b0000000010;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            10'b1000000000: begin
                next_state_temp = 10'b0000000100;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
            default: begin
                next_state_temp = 10'b0000000000;
                out1_temp = 1'b0;
                out2_temp = 1'b0;
            end
        endcase
    end
    
    assign next_state = next_state_temp;
    assign out1 = out1_temp;
    assign out2 = out2_temp;
    
endmodule
