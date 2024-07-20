module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE  = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
    } state_t;

    state_t state, next_state;
    reg [23:0] message;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            done <= 0;
            case(state)
                IDLE: begin
                    if(in[3]) begin
                        message[23:16] <= in;
                        next_state <= BYTE1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                BYTE1: begin
                    message[15:8] <= in;
                    next_state <= BYTE2;
                end
                BYTE2: begin
                    message[7:0] <= in;
                    next_state <= BYTE3;
                end
                BYTE3: begin
                    out_bytes <= message;
                    done <= 1;
                    next_state <= IDLE;
                end
            endcase
        end
    end

endmodule
