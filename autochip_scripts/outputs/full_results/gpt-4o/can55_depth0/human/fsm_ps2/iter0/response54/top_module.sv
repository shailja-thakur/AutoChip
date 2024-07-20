module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state; // FSM state
    reg [1:0] count; // Byte counter

    // States
    localparam IDLE = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               BYTE3 = 2'b11;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
        end else begin
            state <= next_state;

            if (done) begin
                done <= 0;
            end
            
            if (next_state == BYTE1) begin
                count <= 1;
            end else if (next_state == BYTE2 || next_state == BYTE3) begin
                count <= count + 1;
            end else if (next_state == IDLE) begin
                count <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;

        case(state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                if (count == 1) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                if (count == 2) begin
                    next_state = BYTE3;
                end
            end
            BYTE3: begin
                if (count == 3) begin
                    next_state = IDLE;
                    done = 1;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
