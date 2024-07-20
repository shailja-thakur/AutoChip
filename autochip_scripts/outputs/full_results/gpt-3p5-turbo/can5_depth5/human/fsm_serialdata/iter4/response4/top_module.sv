module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state;

    reg [2:0] current_state, next_state;
    reg [7:0] data_bits;
    reg start_received, stop_received;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(current_state or in) begin
        out_byte <= 8'b0;
        done <= 0;
        next_state <= current_state;

        case (current_state)
            IDLE:
                begin
                    if (in == 1'b0)
                        next_state <= START_BIT;
                end
            START_BIT:
                begin
                    if (in == 1'b0)
                        next_state <= DATA_BITS;
                    else
                        next_state <= IDLE;
                end
            DATA_BITS:
                begin
                    if (in == 1'b1)
                        begin
                            data_bits <= {data_bits[6:0], in}; // shift in the data bits
                            next_state <= STOP_BIT;
                        end
                    else
                        data_bits <= {data_bits[6:0], in};
                end
            STOP_BIT:
                begin
                    if (in == 1'b1)
                        begin
                            stop_received <= 1'b1;
                            out_byte <= data_bits; // set the output byte
                            next_state <= IDLE;
                            done <= 1'b1;
                        end
                    else
                        next_state <= IDLE;
                end
            default:
                next_state <= IDLE;
        endcase
    end
endmodule
