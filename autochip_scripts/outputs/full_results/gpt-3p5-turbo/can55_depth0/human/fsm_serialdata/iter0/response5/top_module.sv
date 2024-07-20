module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] byte;
reg prev_bit;
reg start_bit_detected;
reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte <= 0;
        prev_bit <= 0;
        start_bit_detected <= 0;
        bit_counter <= 0;
    end else begin
        case (state)
            0: begin // WAIT_START
                if (in == 0 && prev_bit == 1) begin
                    state <= 1;
                    start_bit_detected <= 1;
                    byte <= 0;
                    bit_counter <= 0;
                end else begin
                    state <= 0;
                    start_bit_detected <= 0;
                end
            end
            1: begin // RECEIVE_BYTE
                if (bit_counter == 7) begin
                    state <= 2;
                end else begin
                    state <= 1;
                end
                bit_counter <= bit_counter + 1;
                byte <= {in, byte[7:1]};
            end
            2: begin // WAIT_STOP
                if (in == 1 && prev_bit == 0) begin
                    state <= 3;
                end else begin
                    state <= 2;
                end
            end
            3: begin // OUTPUT_BYTE
                state <= 0;
            end
        endcase
        prev_bit <= in;
    end
end

assign out_byte = byte;
assign done = (start_bit_detected == 1 && state == 3);

endmodule
