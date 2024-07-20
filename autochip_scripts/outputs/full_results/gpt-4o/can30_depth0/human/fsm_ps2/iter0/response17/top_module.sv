module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum reg [1:0] {WAIT_START = 2'b00, BYTE_2 = 2'b01, BYTE_3 = 2'b10, DONE = 2'b11} state_t;
    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_START;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        done = 0;
        case (state)
            WAIT_START: begin
                if (in[3] == 1) begin
                    next_state = BYTE_2;
                end else begin
                    next_state = WAIT_START;
                end
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
            end
            
            BYTE_3: begin
                done = 1;
                next_state = DONE;
            end
            
            DONE: begin
                done = 0;
                if (in[3] == 1) begin
                    next_state = BYTE_2;
                end else begin
                    next_state = WAIT_START;
                end
            end
        endcase
    end

endmodule
