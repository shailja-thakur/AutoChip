module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (state != DONE) begin
            shift_reg <= {shift_reg[15:0], in};
        end
        if (state == DONE) begin
            out_bytes <= shift_reg;
        end
    end

    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
                done = 0;
            end
            BYTE2: begin
                next_state = BYTE3;
                done = 0;
            end
            BYTE3: begin
                next_state = DONE;
                done = 0;
            end
            DONE: begin
                next_state = BYTE1;
                done = 1;
            end
            default: begin
                next_state = BYTE1;
                done = 0;
            end
        endcase
    end
endmodule
