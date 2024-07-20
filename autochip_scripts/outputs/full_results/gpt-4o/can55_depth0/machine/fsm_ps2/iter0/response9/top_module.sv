module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                done = 0;
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                done = 0;
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 0;
                next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE2;
                end
            end
            default: begin
                done = 0;
                next_state = BYTE1;
            end
        endcase
    end
    
endmodule
