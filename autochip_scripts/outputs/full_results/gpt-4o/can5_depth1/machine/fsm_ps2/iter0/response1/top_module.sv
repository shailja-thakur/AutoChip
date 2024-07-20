module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    reg [1:0] state, next_state;

    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE = 2'b11;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
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
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE2;
                end
            end

            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    // Output Logic
    always @(*) begin
        done = (state == DONE) ? 1'b1 : 1'b0;
    end
endmodule
