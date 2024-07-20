module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;

    reg [1:0] state, next_state;
    reg done_reg;

    assign done = done_reg;

    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            end
            BYTE2: 
                next_state = BYTE3;
            BYTE3: 
                next_state = DONE;
            DONE: begin
                if (in[2] == 1) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            end
            default: 
                next_state = BYTE1;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done_reg <= 0;
        else if (state == DONE)
            done_reg <= 1;
        else
            done_reg <= 0;
    end

endmodule
