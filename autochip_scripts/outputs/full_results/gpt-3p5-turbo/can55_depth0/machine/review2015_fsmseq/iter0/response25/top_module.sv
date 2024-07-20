module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);
    
    reg [3:0] state;
    wire next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state;
    end
    
    assign next_state = (state == 4'b0000 && data) ? 4'b0001 :      // S -> S1
                       (state == 4'b0000 && !data) ? 4'b0000 :     // S -> S
                       (state == 4'b0001 && data) ? 4'b0011 :      // S1 -> S11
                       (state == 4'b0001 && !data) ? 4'b0000 :     // S1 -> S
                       (state == 4'b0011 && data) ? 4'b0011 :      // S11 -> S11
                       (state == 4'b0011 && !data) ? 4'b0110 :     // S11 -> S110
                       (state == 4'b0110 && data) ? 4'b1111 :      // S110 -> Done
                       (state == 4'b0110 && !data) ? 4'b0000 :     // S110 -> S
                       (state == 4'b1111) ? 4'b1111 :              // Done -> Done
                       4'b0000;                                   // Default case
                       
    assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;
    
endmodule
