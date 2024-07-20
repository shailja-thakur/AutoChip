module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE = 2'b11;

    // Define state register
    reg [1:0] state;

    // Define next state
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            done <= 1'b0;
        end else begin
            state <= next_state;
            done <= (state == DONE);
        end
    end

    always @(state or in) begin
        case(state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = DONE;
            end

            DONE: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
        endcase
    end
endmodule
