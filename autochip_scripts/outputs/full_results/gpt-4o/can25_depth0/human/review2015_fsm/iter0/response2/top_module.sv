module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    reg [2:0] state, next_state;
    reg [3:0] pattern_shift;
    integer shift_count;

    // State Encoding
    localparam  IDLE         = 3'b000,
                PATTERN_DET  = 3'b001,
                SHIFT        = 3'b010,
                COUNT        = 3'b011,
                NOTIFY       = 3'b100,
                WAIT_ACK     = 3'b101;

    // Sequential block for state transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'b0000;
            shift_count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            
            case(state)
                IDLE: begin
                    pattern_shift <= {pattern_shift[2:0], data}; // Shift in new data bit
                end
                SHIFT: begin
                    shift_ena <= 1;
                    if (shift_count < 4) begin
                        shift_count <= shift_count + 1;
                    end else begin
                        shift_ena <= 0;
                    end
                end
                COUNT: begin
                    counting <= 1;
                end
                NOTIFY: begin
                    done <= 1;
                end
                WAIT_ACK: begin
                    done <= 0;
                    counting <= 0;
                end
            endcase
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: begin
                if (pattern_shift == 4'b1101)
                    next_state = PATTERN_DET;
            end
            PATTERN_DET: begin
                next_state = SHIFT;
                shift_count = 0;
            end
            SHIFT: begin
                if (shift_count == 4)
                    next_state = COUNT;
            end
            COUNT: begin
                if (done_counting)
                    next_state = NOTIFY;
            end
            NOTIFY: begin
                next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
