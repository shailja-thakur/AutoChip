module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State encoding
    typedef enum reg [1:0] {
        S_IDLE = 2'b00,
        S_BYTE1 = 2'b01,
        S_BYTE2 = 2'b10,
        S_BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            message <= 24'b0;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            if (state == S_BYTE3) begin
                out_bytes <= message;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (in[3]) begin
                    next_state = S_BYTE1;
                    message[23:16] = in;
                end
            end
            
            S_BYTE1: begin
                next_state = S_BYTE2;
                message[15:8] = in;
            end
            
            S_BYTE2: begin
                next_state = S_BYTE3;
                message[7:0] = in;
            end
            
            S_BYTE3: begin
                next_state = S_IDLE;
            end
            
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end
endmodule
