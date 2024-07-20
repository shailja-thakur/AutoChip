module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state, next_state;
    reg [23:0] shift_reg;

    parameter BYTE1 = 3'b000,
              BYTE2 = 3'b001,
              BYTE3 = 3'b010,
              DONE  = 3'b011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                shift_reg <= (shift_reg << 8) | in;
            end
            if (state == DONE) begin
                out_bytes <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end  
        end
    end

    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = in[2] ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

endmodule
