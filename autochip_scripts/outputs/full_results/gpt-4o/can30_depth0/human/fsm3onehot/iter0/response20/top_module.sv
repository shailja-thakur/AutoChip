module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);
    
    // State Transition Logic
    always @(*) begin
        case (state)
            4'b0001: next_state = (in == 1'b0) ? 4'b0001 : 4'b0010; // State A
            4'b0010: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // State B
            4'b0100: next_state = (in == 1'b0) ? 4'b0001 : 4'b1000; // State C
            4'b1000: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // State D
            default: next_state = 4'b0001; // Default to State A
        endcase
    end
    
    // Output Logic
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 only in State D

endmodule
