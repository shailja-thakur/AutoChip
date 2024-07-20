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
    localparam IDLE      = 4'd0;
    localparam START_BIT = 4'd1;
    localparam DATA_BITS = 4'd2;
    localparam STOP_BIT  = 4'd3;
    localparam ERROR     = 4'd4;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            done <= 0;
            data_byte <= 8'd0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        done = 0;

        case(state)
            IDLE: begin
                if (in == 1'b0)   // Detect start bit (0)
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                if (in == 1'b0) 
                    next_state = DATA_BITS;
                else
                    next_state = IDLE;
            end
            
            DATA_BITS: begin
                if (bit_counter < 3'd7) begin
                    next_state = DATA_BITS;
                end
                else begin
                    next_state = STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1;
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1'b1)   // Wait for stop bit to resume
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Data bits counter and byte storage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            data_byte <= 8'd0;
        end
        else if (state == DATA_BITS) begin
            data_byte[bit_counter] <= in;
            bit_counter <= bit_counter + 1;
        end
        else if (state == STOP_BIT || state == ERROR) begin
            bit_counter <= 0;
        end
    end

endmodule
