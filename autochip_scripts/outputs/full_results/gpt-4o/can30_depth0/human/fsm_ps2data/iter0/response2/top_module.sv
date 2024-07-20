module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] byte_buffer;
    reg [7:0] byte1, byte2, byte3;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            byte_buffer <= 24'b0;
        end else begin
            state <= next_state;
            if (state == BYTE3) begin
                done <= 1;
                out_bytes <= byte_buffer;
            end else begin
                done <= 0;
            end
        end
    end

    // Next state logic and datapath updates
    always @(*) begin
        next_state = state;
        byte_buffer = {byte1, byte2, byte3};
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    byte1 = in;
                    next_state = BYTE1;
                end
            end

            BYTE1: begin
                byte2 = in;
                next_state = BYTE2;
            end
            
            BYTE2: begin
                byte3 = in;
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = IDLE;
                byte1 = 0;
                byte2 = 0;
                byte3 = 0;
            end
        endcase
    end
endmodule
