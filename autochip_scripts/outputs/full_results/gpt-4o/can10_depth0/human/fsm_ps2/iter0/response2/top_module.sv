module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // Define state names using a parameter
    parameter IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, DONE = 2'b11;
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == DONE)
            done <= 1'b1;
        else
            done <= 1'b0;
    end
endmodule
