module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    // Define the states of the finite state machine
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    reg [2:0] state;        // Current state of the FSM
    reg [7:0] data_byte;    // Data byte being received
    reg [2:0] bit_count;    // Number of bits received
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            bit_count <= 0;
        end else begin
            case (state)
                IDLE:
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        data_byte <= 8'b0;
                        bit_count <= 0;
                    end
                START_BIT:
                    if (in == 1'b0) begin
                        state <= DATA_BITS;
                        data_byte <= 8'b0;
                        bit_count <= 0;
                    end else begin
                        state <= IDLE;
                    end
                DATA_BITS:
                    if (bit_count == 8) begin
                        state <= STOP_BIT;
                    end else begin
                        data_byte <= {in, data_byte[7:1]};
                        bit_count <= bit_count + 1;
                    end
                STOP_BIT:
                    if (bit_count == 9 && in == 1'b1) begin
                        state <= IDLE;
                        done <= 1;
                        out_byte <= data_byte;
                    end else begin
                        state <= IDLE;
                        done <= 0;
                    end
            endcase
        end
    end
    
endmodule
