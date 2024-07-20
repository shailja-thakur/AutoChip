module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;
    localparam BYTE1 = 2'b00,
               BYTE2 = 2'b01,
               BYTE3 = 2'b10,
               DONE  = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};
            end
        end
    end

    always @(*) begin
        case (state)
            BYTE1: begin
                done = 0;
                if (in[3] == 1'b1) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                done = 0;
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 0;
                next_state = DONE;
            end
            DONE: begin
                done = 1;
                next_state = BYTE1;
            end
            default: begin
                done = 0;
                next_state = BYTE1;
            end
        endcase
    end

    always @(*) begin
        if (state == DONE) begin
            out_bytes = shift_reg;
        end else begin
            out_bytes = 24'b0;
        end
    end

endmodule
