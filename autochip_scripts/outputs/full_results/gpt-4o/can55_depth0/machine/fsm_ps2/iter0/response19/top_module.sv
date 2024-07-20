module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State definitions
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: if (in[2] == 1'b1) next_state = BYTE2; else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: if (in[2] == 1'b0) next_state = BYTE1; else next_state = BYTE2;
            default: next_state = BYTE1;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else begin
            done <= (state == DONE);
        end
    end
endmodule
