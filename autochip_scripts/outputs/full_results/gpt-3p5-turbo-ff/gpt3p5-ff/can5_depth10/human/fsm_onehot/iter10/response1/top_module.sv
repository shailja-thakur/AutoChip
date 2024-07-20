module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
);
    
    // Define the logic equations for the states transitions and outputs
    always @(in or state) begin
        case(state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001;
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000011;
            10'b0000000011: next_state = in ? 10'b0000000001 : 10'b0000000100;
            10'b0000000100: next_state = in ? 10'b0000000101 : 10'b0000000010;
            10'b0000000101: next_state = in ? 10'b0000001000 : 10'b0000000101;
            10'b0000000110: next_state = in ? 10'b0000001001 : 10'b0000000111;
            10'b0000000111: next_state = in ? 10'b0000000001 : 10'b0000000111;
            10'b0000001000: next_state = in ? 10'b0000000010 : 10'b0000001000;
            10'b0000001001: next_state = in ? 10'b0000000010 : 10'b0000001001;
            default: next_state = in ? 10'b0000000010 : 10'b0000000011;
        endcase
    end
    
    assign out1 = (state == 10'b0000000110) || (state == 10'b0000001001);
    assign out2 = (state == 10'b0000000111) && in;
    
endmodule
