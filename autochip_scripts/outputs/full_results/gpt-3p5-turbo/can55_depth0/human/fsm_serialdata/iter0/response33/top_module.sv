module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] received_byte;
reg [7:0] shift_register;
reg start_bit_found, stop_bit_found;
reg [2:0] bit_counter;

parameter IDLE = 0, START_BIT = 1, RECEIVING_BITS = 2, STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        received_byte <= 8'b0;
        shift_register <= 8'b0;
        start_bit_found <= 0;
        stop_bit_found <= 0;
        bit_counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    start_bit_found <= 1;
                    bit_counter <= 0;
                    shift_register <= 8'b0;
                end
            end
            START_BIT: begin
                if (bit_counter == 7) begin
                    state <= RECEIVING_BITS;
                    bit_counter <= 0;
                end else begin
                    bit_counter <= bit_counter + 1;
                    shift_register <= {shift_register[6:0], in};
                end
            end
            RECEIVING_BITS: begin
                if (bit_counter == 7) begin
                    state <= STOP_BIT;
                    stop_bit_found <= 1;
                end else begin
                    bit_counter <= bit_counter + 1;
                    shift_register <= {shift_register[6:0], in};
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    received_byte <= shift_register;
                    state <= IDLE;
                    start_bit_found <= 0;
                    stop_bit_found <= 0;
                end
            end
        endcase
    end
end

assign out_byte = received_byte;
assign done = stop_bit_found;

endmodule
