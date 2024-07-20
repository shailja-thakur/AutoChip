module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    
    // State encoding
    localparam IDLE  = 3'b000,
               S1    = 3'b001,
               S2    = 3'b010,
               S3    = 3'b011,
               S4    = 3'b100,
               DONE  = 3'b101;
               
    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE:  next_state = S1;
            S1:    next_state = S2;
            S2:    next_state = S3;
            S3:    next_state = S4;
            S4:    next_state = DONE;
            DONE:  next_state = DONE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1;
        else if (state == S1 || state == S2 || state == S3 || state == S4)
            shift_ena <= 1;
        else
            shift_ena <= 0;
    end
    
endmodule
