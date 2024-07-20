module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        RECEIVE_BITS,
        STOP_BIT
    } state_t;

    reg [7:0] reg_byte;
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            reg_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE:
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        reg_byte <= 8'b0;
                    end
                START_BIT:
                    if (in == 1'b1) begin
                        state <= RECEIVE_BITS;
                    end
                RECEIVE_BITS:
                    if (in == 1'b0) begin
                        reg_byte <= {reg_byte[6:0], in};
                    end
                    if (reg_byte == 8'b11111110) begin
                        state <= STOP_BIT;
                    end
                STOP_BIT:
                    if (in == 1'b1) begin
                        done <= 1'b1;
                        out_byte <= reg_byte[7:0];
                        state <= IDLE;
                    end
            endcase
        end
    end

endmodule
