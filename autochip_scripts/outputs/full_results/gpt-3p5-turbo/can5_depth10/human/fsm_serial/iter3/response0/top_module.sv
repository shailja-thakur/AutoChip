module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    localparam IDLE = 2'b00;
    localparam START_BIT = 2'b01;
    localparam DATA_BITS = 2'b10;
    localparam STOP_BIT = 2'b11;
    localparam NUM_DATA_BITS = 8;

    // Define signals
    reg [1:0] state;
    reg [7:0] data;
    reg start_bit_detected;
    reg stop_bit_detected;
    reg [3:0] bit_count;

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 0;
            start_bit_detected <= 0;
            stop_bit_detected <= 0;
            bit_count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 0) begin
                        state <= START_BIT;
                        bit_count <= 0;
                    end
                end
                START_BIT: begin
                    state <= DATA_BITS;
                    start_bit_detected <= 1;
                    bit_count <= bit_count + 1;
                end
                DATA_BITS: begin
                    if (bit_count < NUM_DATA_BITS) begin
                        data <= {data[6:0], in};
                        bit_count <= bit_count + 1;
                    end else begin
                        bit_count <= 0;
                        if (start_bit_detected && (in == 1)) begin
                            state <= STOP_BIT;
                        end else begin
                            state <= IDLE;
                        end
                    end
                end
                STOP_BIT: begin
                    if (in == 1) begin
                        stop_bit_detected <= 1;
                        state <= IDLE;
                        done <= 1;
                    end else begin
                        state <= DATA_BITS;
                    end
                end
            endcase
        end
    end

endmodule
