module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    // Define signals
    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    reg [2:0] state;
    reg [7:0] receive_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
            out_byte <= 0;
        end else begin
            case (state)
                IDLE:
                    if (in) begin
                        state <= START_BIT;
                        bit_count <= 0;
                    end
                START_BIT:
                    if (!in) begin
                        state <= IDLE;
                    end else if (bit_count == 8) begin
                        state <= STOP_BIT;
                        receive_byte <= shift_reg;
                    end else begin
                        shift_reg <= {shift_reg[6:0], in};
                        bit_count <= bit_count + 1;
                    end
                DATA_BITS:
                    if (!in) begin
                        state <= IDLE;
                    end else if (bit_count == 8) begin
                        state <= STOP_BIT;
                        receive_byte <= shift_reg;
                    end else begin
                        shift_reg <= {shift_reg[6:0], in};
                        bit_count <= bit_count + 1;
                    end
                STOP_BIT:
                    if (in) begin
                        state <= IDLE;
                    end else begin
                        out_byte <= receive_byte;
                        done <= 1;
                        state <= IDLE;
                    end
            endcase
        end
    end

endmodule
