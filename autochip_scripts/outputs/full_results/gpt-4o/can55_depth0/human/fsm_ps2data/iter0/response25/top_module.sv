module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // State encoding
    typedef enum reg [1:0] {
        WAIT_FOR_BYTE1 = 2'd0,
        BYTE1_RECEIVED = 2'd1,
        BYTE2_RECEIVED = 2'd2,
        BYTE3_RECEIVED = 2'd3
    } state_t;

    state_t state, next_state;
    
    reg [23:0] message;
    reg [7:0] byte_count;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_BYTE1;
        else
            state <= next_state;
    end
    
    // Next state logic and output signal generation
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            WAIT_FOR_BYTE1: begin
                if (in[3]) begin
                    next_state = BYTE1_RECEIVED;
                    byte_count = 1;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
                byte_count = 2;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
                byte_count = 3;
            end
            BYTE3_RECEIVED: begin
                next_state = WAIT_FOR_BYTE1;
                done = 1;
            end
        endcase
    end
    
    // Collect message bytes
    always @(posedge clk) begin
        if (reset) begin
            message <= 24'b0;
            out_bytes <= 24'b0;
        end else if (done) begin
            out_bytes <= message;
        end else begin
            message <= {message[15:0], in};
        end
    end
    
endmodule
