module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_count;
    reg [7:0] byte_reg;

    localparam IDLE      = 4'd0,
               START_BIT = 4'd1,
               DATA_BITS = 4'd2,
               STOP_BIT  = 4'd3,
               DONE      = 4'd4,
               ERROR     = 4'd5;
               
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (in == 0)  // Confirm it's a valid start bit
                    next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1)  // Confirm it's a valid stop bit
                    next_state = DONE;
                else
                    next_state = ERROR;
            end
            DONE: begin
                done = 1;
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1)  // Wait for line to go idle before retrying
                    next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 0;
            byte_reg <= 8'd0;
            out_byte <= 8'd0;
        end
        else if (state == DATA_BITS && bit_count < 3'd8) begin
            byte_reg[bit_count] <= in;
            bit_count <= bit_count + 3'd1;
        end
        else if (state == DONE) begin
            out_byte <= byte_reg;
            bit_count <= 0;
            byte_reg <= 8'd0;
        end
        else if (state == IDLE || state == ERROR) begin
            bit_count <= 0;
            byte_reg <= 8'd0;
        end
    end
endmodule
