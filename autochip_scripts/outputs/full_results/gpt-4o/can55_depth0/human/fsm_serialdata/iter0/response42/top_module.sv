module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    // State encoding
    localparam IDLE       = 4'b0000;
    localparam START_BIT  = 4'b0001;
    localparam DATA_BITS  = 4'b0010;
    localparam STOP_BIT   = 4'b0011;
    localparam DONE       = 4'b0100;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            shift_reg <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end else if (state == DONE) begin
                out_byte <= shift_reg;
                done <= 1'b1;
            end else if (state == IDLE) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'd0;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = DONE;
                else
                    next_state = IDLE; // Wait for stop bit to be correct
            end
            DONE: begin
                next_state = IDLE; // Ready for next byte
            end
        endcase
    end

endmodule
