module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [1:0] state, next_state;
    reg [1:0] byte_count;
    
    // States
    localparam IDLE     = 2'b00,
               BYTE_1   = 2'b01,
               BYTE_2   = 2'b10,
               BYTE_3   = 2'b11;
    
    // State transition logic
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: begin
                if (in[3]) // Check if in[3] is 1
                    next_state = BYTE_1;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = IDLE; // After third byte, go back to IDLE
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
    
    // Byte count logic
    always @(posedge clk) begin
        if (reset)
            byte_count <= 2'b00;
        else if (state == IDLE && in[3])
            byte_count <= 2'b01;
        else if (state == BYTE_1)
            byte_count <= 2'b10;
        else if (state == BYTE_2)
            byte_count <= 2'b11;
        else if (state == BYTE_3)
            byte_count <= 2'b00;
    end
    
    // Done signal logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == BYTE_3)
            done <= 1'b1;
        else
            done <= 1'b0;
    end
endmodule
