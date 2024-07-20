module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;

    // State encoding
    localparam IDLE   = 4'b0000,
               START  = 4'b0001,
               DATA   = 4'b0010,
               STOP   = 4'b0011,
               ERROR  = 4'b0100;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end
            START: begin
                if (in == 0)
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            DATA: begin
                if (bit_counter == 7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // Bit counter and data byte
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'b000;
            data_byte <= 8'b00000000;
        end else if (state == DATA) begin
            bit_counter <= bit_counter + 1;
            data_byte <= {in, data_byte[7:1]};
        end else begin
            bit_counter <= 3'b000;
        end
    end

endmodule
