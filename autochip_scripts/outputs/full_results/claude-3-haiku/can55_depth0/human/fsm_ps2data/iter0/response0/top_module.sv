module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the states of the FSM
localparam [1:0] WAIT_START = 2'b00,
                 WAIT_SECOND = 2'b01,
                 WAIT_THIRD = 2'b10,
                 COMPLETE = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        WAIT_START: begin
            if (in[3]) begin
                next_state = WAIT_SECOND;
            end else begin
                next_state = WAIT_START;
            end
        end
        WAIT_SECOND: begin
            next_state = WAIT_THIRD;
        end
        WAIT_THIRD: begin
            next_state = COMPLETE;
        end
        COMPLETE: begin
            next_state = WAIT_START;
        end
        default: begin
            next_state = WAIT_START;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        out_bytes <= 'h0;
        done <= 1'b0;
    end else begin
        case (state)
            WAIT_START: begin
                out_bytes <= 'h0;
                done <= 1'b0;
            end
            WAIT_SECOND: begin
                out_bytes[23:16] <= in;
            end
            WAIT_THIRD: begin
                out_bytes[15:8] <= in;
            end
            COMPLETE: begin
                out_bytes[7:0] <= in;
                done <= 1'b1;
            end
            default: begin
                out_bytes <= 'h0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
