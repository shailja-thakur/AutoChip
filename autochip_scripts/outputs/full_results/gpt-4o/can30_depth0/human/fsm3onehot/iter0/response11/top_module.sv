module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);
    
    // Determine next state based on current state and input
    always @(*) begin
        case (state)
            4'b0001: next_state = (in) ? 4'b0010 : 4'b0001; // A
            4'b0010: next_state = (in) ? 4'b0010 : 4'b0100; // B
            4'b0100: next_state = (in) ? 4'b1000 : 4'b0001; // C
            4'b1000: next_state = (in) ? 4'b0010 : 4'b0100; // D
            default: next_state = 4'b0001; // default to state A
        endcase
    end
    
    // Determine output based on current state
    assign out = (state == 4'b1000) ? 1 : 0; // Output is 1 only in state D
    
endmodule
