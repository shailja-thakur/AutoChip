module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;

    // State encoding
    parameter WAIT = 2'b00;
    parameter BYTE1 = 2'b01;
    parameter BYTE2 = 2'b10;
    parameter BYTE3 = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = WAIT;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = WAIT;
                end
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else if (state == BYTE3) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
