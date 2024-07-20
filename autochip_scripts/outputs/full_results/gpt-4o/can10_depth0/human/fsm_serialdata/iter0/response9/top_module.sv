module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data_buffer;
    reg [2:0] bit_counter;

    // State encoding
    localparam IDLE       = 4'b0000,
               START_BIT  = 4'b0001,
               RECEIVE    = 4'b0010,
               STOP_BIT   = 4'b0100,
               CHECK_STOP = 4'b1000;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            data_buffer <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state; // Default state stays the same
        done = 1'b0;        // Default done signal is low

        case(state)
            IDLE: begin
                if (in == 1'b0)  // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = RECEIVE;  // Transition to RECEIVE state
                bit_counter = 3'b0;
            end

            RECEIVE: begin
                if (bit_counter < 3'd7) begin
                    bit_counter = bit_counter + 1;
                end else begin
                    data_buffer = {in, data_buffer[7:1]}; // Shift in the last data bit
                    next_state = STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin  // Stop bit detected
                    next_state = CHECK_STOP;
                end else begin         // Not a stop bit, go back to IDLE
                    next_state = IDLE;
                end
            end

            CHECK_STOP: begin
                done = 1'b1;
                out_byte = data_buffer;
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Data shifting logic
    always @(posedge clk) begin
        if (state == RECEIVE) begin
            data_buffer <= {in, data_buffer[7:1]};
        end
    end

endmodule
