module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);
    
    // Internal signals
    reg [2:0] next_state;
    
    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b000; // Reset to B0
        end else begin
            state <= next_state; // Update current state
        end
    end
    
    always @(state) begin
        case (state)
            3'b000: next_state = 3'b001; // B0 -> B1
            3'b001: next_state = 3'b010; // B1 -> B2
            3'b010: next_state = 3'b011; // B2 -> B3
            3'b011: next_state = 3'b100; // B3 -> Done
            default: next_state = 3'b100; // Done (if state is not B0, B1, B2, B3)
        endcase
    end
    
    assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) ? 1'b1 : 1'b0;
    
endmodule
