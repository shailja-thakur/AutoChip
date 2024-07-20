module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;
    
    // State Encoding
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;

    // State Transition Logic
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // State Register Update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Output and Shift Register Update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (next_state)
                BYTE1: if (state == DONE) shift_reg <= in;
                       else shift_reg <= in;
                BYTE2: shift_reg <= {shift_reg[15:0], in};
                BYTE3: shift_reg <= {shift_reg[15:0], in};
                DONE: begin
                    shift_reg <= {shift_reg[15:0], in};
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
                default: shift_reg <= 24'b0;
            endcase
        end
    end

    // Clear done signal except in DONE state
    always @(posedge clk) begin
        if (state != DONE) begin
            done <= 1'b0;
        end
    end

endmodule
