module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    reg [3:0] state;
    reg [3:0] next_state;
    reg [7:0] data_byte;
    reg start_bit_detected;
    reg stop_bit_detected;
    reg prev_in;

    parameter IDLE = 4'b0000;
    parameter START_BIT = 4'b0001;
    parameter DATA_BITS = 4'b0010;
    parameter STOP_BIT = 4'b0011;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            start_bit_detected <= 0;
            stop_bit_detected <= 0;
            prev_in <= 1;
        end
        else begin
            state <= next_state;
            data_byte <= {data_byte[6:0], in};
            start_bit_detected <= 0;
            stop_bit_detected <= 0;
  
            case (state)
                IDLE: begin
                    if (prev_in == 1 && in == 0) begin
                        next_state <= START_BIT;
                        start_bit_detected <= 1;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end
                START_BIT: begin
                    next_state <= DATA_BITS;
                end
                DATA_BITS: begin
                    if (data_byte == 8'b11111110) begin
                        next_state <= STOP_BIT;
                    end
                    else begin
                        next_state <= DATA_BITS;
                    end
                end
                STOP_BIT: begin
                    if (prev_in == 0 && in == 1) begin
                        next_state <= IDLE;
                        stop_bit_detected <= 1;
                    end
                    else begin
                        next_state <= STOP_BIT;
                    end
                end
                default: begin
                    next_state <= IDLE;
                end
            endcase
            
            prev_in <= in;
        end
    end

    assign out_byte = data_byte;
    assign done = stop_bit_detected;

endmodule
