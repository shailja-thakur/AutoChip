module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state; // 2-bit state register to hold the current state
    reg [23:0] shift_reg;

    localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            done <= 0;
            shift_reg <= 0;
        end else begin
            state <= next_state;
            if (next_state == DONE)
                done <= 1;
            else
                done <= 0;
                
            if (state != DONE) 
                shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and insert in
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: 
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            BYTE2: 
                next_state = BYTE3;
            BYTE3: 
                next_state = DONE;
            DONE: 
                if (in[2] == 1)
                    next_state = BYTE1;
                else
                    next_state = BYTE1;
            default: 
                next_state = BYTE1;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out_bytes <= 0;
        else if (done)
            out_bytes <= shift_reg;
    end

endmodule
