module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;
    
    // State encoding
    localparam B0 = 3'b000, 
               B1 = 3'b001, 
               B2 = 3'b010, 
               B3 = 3'b011, 
               Done = 3'b100;
    
    // State transition
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B0 || state == B1 || state == B2 || state == B3)
            shift_ena = 1'b1;
        else
            shift_ena = 1'b0;
    end

endmodule
