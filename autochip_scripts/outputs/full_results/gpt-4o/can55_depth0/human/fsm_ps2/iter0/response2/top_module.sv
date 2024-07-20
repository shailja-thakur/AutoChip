module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state, next_state;
    reg done_reg;

    // State encoding
    localparam IDLE  = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            done_reg <= 1'b0;
        else if (state == BYTE3)
            done_reg <= 1'b1;
        else
            done_reg <= 1'b0;
    end

    assign done = done_reg;

endmodule
