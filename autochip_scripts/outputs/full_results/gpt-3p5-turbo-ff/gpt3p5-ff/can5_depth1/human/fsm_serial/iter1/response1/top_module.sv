module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // State definition
    typedef enum logic [3:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    // Internal signals
    reg [3:0] current_state;
    reg [7:0] received_byte;
    reg found_start_bit;
    reg [2:0] bit_count;

    // Output signal assignment
    assign done = (current_state == STOP_BIT);

    // State machine logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            received_byte <= 8'b0;
            found_start_bit <= 0;
            bit_count <= 0;
        end else begin
            case (current_state)
                IDLE:
                    if (in == 1'b0) begin
                        current_state <= START_BIT;
                        received_byte <= 8'b0;
                        found_start_bit <= 1;
                        bit_count <= 0;
                    end else begin
                        current_state <= IDLE;
                        received_byte <= 8'b0;
                        found_start_bit <= 0;
                        bit_count <= 0;
                    end
                START_BIT:
                    if (found_start_bit) begin
                        current_state <= DATA_BITS;
                        received_byte[bit_count] <= in;
                        bit_count <= bit_count + 1;
                    end else begin
                        current_state <= IDLE;
                        received_byte <= 8'b0;
                        found_start_bit <= 0;
                        bit_count <= 0;
                    end
                DATA_BITS:
                    if (bit_count == 7) begin
                        current_state <= STOP_BIT;
                        received_byte[bit_count] <= in;
                    end else begin
                        current_state <= DATA_BITS;
                        received_byte[bit_count] <= in;
                        bit_count <= bit_count + 1;
                    end
                STOP_BIT:
                    if (in == 1'b1) begin
                        current_state <= IDLE;
                    end else begin
                        current_state <= STOP_BIT;
                    end
            endcase
        end
    end

endmodule
