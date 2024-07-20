module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [7:0] data;
    reg [2:0] bit_cnt;

    // State encoding
    localparam IDLE     = 4'b0000;
    localparam START    = 4'b0001;
    localparam DATA     = 4'b0010;
    localparam STOP     = 4'b0011;
    localparam ERROR    = 4'b0100;

    // State transitions and logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
            out_byte <= 8'd0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            data <= 8'd0;
        end else if (state == DATA) begin
            data[bit_cnt] <= in;
        end else if (state == IDLE) begin
            bit_cnt <= 0;
        end else begin
            data <= data;
        end
    end

    // State transition control
    always @(*) begin
        next_state = state;
        done = 0;

        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START;
            end

            START: begin
                if (in == 0)  // Start bit confirmed
                    next_state = DATA;
                else
                    next_state = IDLE;  // False start bit, stay in IDLE
            end

            DATA: begin
                if (bit_cnt == 7) begin
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in == 1) begin  // Stop bit confirmed
                    next_state = IDLE;
                    out_byte = data;
                    done = 1;
                end else begin
                    next_state = ERROR;  // Wait for stop bit
                end
            end

            ERROR: begin
                if (in == 1) begin  // Stop bit found
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    // Bit counter for DATA state
    always @(posedge clk) begin
        if (reset) begin
            bit_cnt <= 0;
        end else if (state == DATA) begin
            if (bit_cnt < 7)
                bit_cnt <= bit_cnt + 1;
            else
                bit_cnt <= 0;
        end else begin
            bit_cnt <= 0;
        end
    end

endmodule
