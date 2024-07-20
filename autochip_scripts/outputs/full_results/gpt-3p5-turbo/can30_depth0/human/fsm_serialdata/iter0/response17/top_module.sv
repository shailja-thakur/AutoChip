module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [3:0] state;
reg [2:0] count;
reg [7:0] byte_buffer;
reg start_bit_detected;
reg stop_bit_detected;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        byte_buffer <= 0;
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case(state)
            0: begin // IDLE
                if (in) begin
                    state <= 1;
                    count <= 0;
                    byte_buffer <= 0;
                    start_bit_detected <= 1;
                    stop_bit_detected <= 0;
                end
            end
            1: begin // RECEIVE DATA BITS
                if (in && count < 8) begin
                    count <= count + 1;
                    byte_buffer <= {in, byte_buffer[7:1]};
                end else if (!in) begin
                    state <= 2;
                    count <= 0;
                end
            end
            2: begin // VERIFY STOP BIT
                if (in && count == 0) begin
                    if (byte_buffer == 8'b00000000) begin
                        stop_bit_detected <= 1;
                    end else begin
                        state <= 0;
                        start_bit_detected <= 0;
                    end
                end else if (!in && count == 0) begin
                    state <= 0;
                    stop_bit_detected <= 0;
                    done <= 1;
                    out_byte <= byte_buffer;
                end else if (count >= 1) begin
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

endmodule
