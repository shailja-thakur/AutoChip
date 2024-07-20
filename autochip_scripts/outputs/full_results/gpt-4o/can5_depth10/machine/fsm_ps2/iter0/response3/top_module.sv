module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;
    
    // State encoding
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;
    
    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = in[2] ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= BYTE1;
        else 
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 1'b0;
        else if (state == DONE)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule
