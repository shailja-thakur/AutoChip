module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [7:0] data_byte;
reg [2:0] state;
reg start_bit_detected;
reg [2:0] count;

// Idle state
parameter IDLE = 3'b000;
// Start bit detected state
parameter START_BIT_DETECTED = 3'b001;
// Receive data bits state
parameter RECEIVE_DATA_BITS = 3'b010;
// Verify stop bit state
parameter VERIFY_STOP_BIT = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_bit_detected <= 0;
        count <= 0;
        data_byte <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT_DETECTED;
                end
            end
            START_BIT_DETECTED: begin
                state <= RECEIVE_DATA_BITS;
                start_bit_detected <= 1;
            end
            RECEIVE_DATA_BITS: begin
                if (count == 7) begin
                    state <= VERIFY_STOP_BIT;
                end else begin
                    count <= count + 1;
                    data_byte <= {data_byte[6:0], in};
                end
            end
            VERIFY_STOP_BIT: begin
                if (count == 8 && in == 1) begin
                    done <= 1;
                    out_byte <= data_byte;
                    state <= IDLE;
                end else if (count == 8 && in == 0) begin
                    done <= 0;
                    state <= START_BIT_DETECTED;
                end else if (in == 1) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
