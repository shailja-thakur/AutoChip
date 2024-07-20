module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
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

    // State Machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            if (state != DONE) begin
                out_bytes <= {out_bytes[15:0], in};
            end
            
            if (state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        case (state)
            BYTE1: if (in[3]) next_state = BYTE2; else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

endmodule
