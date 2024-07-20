module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define state encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1) 
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
                if (in[2] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= BYTE1;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (current_state == DONE)
            done = 1'b1;
        else
            done = 1'b0;
    end

endmodule
