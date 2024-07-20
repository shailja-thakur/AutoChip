module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_buffer;

    localparam IDLE = 4'd0,
               START_BIT = 4'd1,
               DATA_BITS = 4'd2,
               STOP_BIT = 4'd3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'd0;
            done <= 1'b0;
            bit_count <= 4'd0;
            data_buffer <= 8'd0;
        end
        else begin
            state <= next_state;
            
            if (state == START_BIT) begin
                bit_count <= 4'd0;
                data_buffer <= 8'd0;
            end

            if (state == DATA_BITS) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
            end

            if (state == STOP_BIT) begin
                out_byte <= data_buffer;
                done <= 1'b1;
            end
            else
                done <= 1'b0;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 4'd8)
                    next_state = STOP_BIT;
            end

            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP_BIT; // wait until we find the stop bit(1)
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
