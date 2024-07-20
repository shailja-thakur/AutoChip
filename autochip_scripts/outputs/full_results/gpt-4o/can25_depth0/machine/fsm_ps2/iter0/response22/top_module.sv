module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
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

    // Output logic
    always @(*) begin
        done = (state == DONE);
    end

endmodule
