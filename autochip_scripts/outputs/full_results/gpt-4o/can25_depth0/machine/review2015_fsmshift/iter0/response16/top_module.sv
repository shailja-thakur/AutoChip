module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    // Declare state register
    reg [2:0] state, next_state;
    
    // State encoding
    localparam B0 = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam DONE = 3'b100;
    
    // State transition on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = DONE;
            default: next_state = DONE;
        endcase
    end
    
    // Output logic
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    
endmodule
