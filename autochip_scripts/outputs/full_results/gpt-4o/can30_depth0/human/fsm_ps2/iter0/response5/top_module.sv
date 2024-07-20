module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum reg [1:0] {
        WAIT_FOR_START = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] byte_count;  // We need to count to 3 bytes per message

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            byte_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state != WAIT_FOR_START) begin
                byte_count <= byte_count + 1;
            end else begin
                byte_count <= 2'b00;
            end
        end
    end

    always @(*) begin
        done = 1'b0;
        next_state = state;
        
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED;
                end
            end

            BYTE1_RECEIVED: begin
                if (byte_count == 2'b01) begin
                    next_state = BYTE2_RECEIVED;
                end
            end

            BYTE2_RECEIVED: begin
                if (byte_count == 2'b10) begin
                    done = 1'b1;
                    next_state = WAIT_FOR_START;
                end
            end
        endcase
    end

endmodule
