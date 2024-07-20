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
    reg [23:0] message;
    
    // Sequential logic: state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    // Sequential logic: output and message assembly
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0;
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        message[23:16] <= in;
                    end
                end
                BYTE1: begin
                    message[15:8] <= in;
                end
                BYTE2: begin
                    message[7:0] <= in;
                end
                BYTE3: begin
                    out_bytes <= message;
                    done <= 1'b1;
                end
            endcase
        end
    end
    
endmodule
