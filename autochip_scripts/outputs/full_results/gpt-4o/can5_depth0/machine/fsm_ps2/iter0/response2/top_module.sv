module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [1:0] state, next_state;

    localparam BYTE1 = 2'b00, 
               BYTE2 = 2'b01, 
               BYTE3 = 2'b10, 
               DONE = 2'b11;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end
    
    // Output logic
    assign done = (state == DONE);
    
endmodule
