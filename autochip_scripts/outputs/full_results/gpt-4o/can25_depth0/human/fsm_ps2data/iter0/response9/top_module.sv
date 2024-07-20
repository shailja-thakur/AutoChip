module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] message;
    
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message <= 24'd0;
            out_bytes <= 24'd0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (done) begin
                out_bytes <= message;
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                    message[23:16] = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                message[15:8] = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                message[7:0] = in;
            end
            BYTE3: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
