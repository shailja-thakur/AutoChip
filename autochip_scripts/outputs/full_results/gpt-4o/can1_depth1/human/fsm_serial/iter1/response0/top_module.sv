module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state, next_state;
    reg [3:0] bit_counter;

    // State encoding
    localparam IDLE       = 4'd0;
    localparam START_BIT  = 4'd1;
    localparam DATA_BITS  = 4'd2;
    localparam STOP_BIT   = 4'd3;
    localparam DONE       = 4'd4;
    localparam ERR_STATE  = 4'd5;

    // State register and bit counter register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 4'd0;
            done <= 0;
        end else begin
            state <= next_state;

            if (state == DATA_BITS) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 4'd0;
            end

            if (state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) next_state = START_BIT; // Detect start bit
            end
            START_BIT: begin
                if (in == 1'b0) next_state = DATA_BITS;
                else next_state = IDLE; // False start bit detected
            end
            DATA_BITS: begin
                if (bit_counter == 4'd8) next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) next_state = DONE;
                else next_state = ERR_STATE; // Error if stop bit is not 1
            end
            DONE: begin
                next_state = IDLE; // Go back to idle after done
            end
            ERR_STATE: begin
                if (in == 1'b1) next_state = IDLE; // Wait for line to be idle
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
