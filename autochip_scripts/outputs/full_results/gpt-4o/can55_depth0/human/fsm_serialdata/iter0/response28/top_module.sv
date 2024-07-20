module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [3:0] state, next_state;
    reg [7:0] buffer;
    reg [2:0] bit_counter;

    localparam IDLE      = 4'b0000;
    localparam START     = 4'b0001;
    localparam DATA_BITS = 4'b0010;
    localparam STOP      = 4'b0011;

    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*)
    begin
        case (state)
            IDLE: 
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            START:
                next_state = DATA_BITS;
            DATA_BITS:
                if (bit_counter == 3'b111)
                    next_state = STOP;
                else
                    next_state = DATA_BITS;
            STOP:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP;
            default:
                next_state = IDLE;
        endcase
    end

    // Output and state-dependent operations
    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            buffer <= 8'b0;
            bit_counter <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end 
        else 
        begin
            case (state)
                IDLE: 
                begin
                    done <= 1'b0;
                    bit_counter <= 3'b0;
                end
                START: 
                begin
                    // Nothing specific to do
                end
                DATA_BITS: 
                begin
                    buffer <= {in, buffer[7:1]}; // Shift in the incoming bit
                    bit_counter <= bit_counter + 1;
                end
                STOP:
                begin
                    if (in == 1'b1) // Stop bit validation
                    begin
                        out_byte <= buffer;
                        done <= 1'b1;
                    end
                    else
                    begin
                        // In case stop bit is wrong, wait here until we read a correct one
                        done <= 1'b0;
                    end
                end
                default: 
                begin
                    // Nothing to do here
                end
            endcase
        end
    end
endmodule
