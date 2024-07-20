module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    // Define signals
    logic [2:0] state;
    logic [7:0] data_byte;

    // Initialize signals
    initial begin
        state = IDLE;
        data_byte = 8'b0;
    end

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                    end
                end

                START_BIT: begin
                    if (in == 1'b1) begin
                        state <= DATA_BITS;
                    end
                end

                DATA_BITS: begin
                    data_byte <= {data_byte[6:0], in};
                    if ($countones(data_byte) == 8) begin
                        state <= STOP_BIT;
                    end
                end

                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
