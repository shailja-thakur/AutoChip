module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    // State encoding
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
            shift_reg <= 24'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in[3] == 1) next_state = BYTE1;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: begin
                next_state = IDLE;
                done = 1;
            end
        endcase
    end
    
    // Output logic and shift register
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            case (state)
                BYTE1: shift_reg <= {shift_reg[15:0], in};
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in};
                    out_bytes <= {shift_reg[15:0], in};
                end
            endcase
        end
    end

endmodule
