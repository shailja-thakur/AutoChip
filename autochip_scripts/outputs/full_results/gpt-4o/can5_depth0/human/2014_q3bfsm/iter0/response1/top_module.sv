module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] y, Y;  // state and next state

    // State definitions
    localparam STATE_0 = 3'b000;
    localparam STATE_1 = 3'b001;
    localparam STATE_2 = 3'b010;
    localparam STATE_3 = 3'b011;
    localparam STATE_4 = 3'b100;

    // State transitions and output logic
    always @(*) begin
        case (y)
            STATE_0: begin
                if (x == 0) 
                    Y = STATE_0;
                else 
                    Y = STATE_1;
                z = 0;
            end
            STATE_1: begin
                if (x == 0) 
                    Y = STATE_1;
                else 
                    Y = STATE_4;
                z = 0;
            end
            STATE_2: begin
                if (x == 0) 
                    Y = STATE_2;
                else 
                    Y = STATE_1;
                z = 0;
            end
            STATE_3: begin
                if (x == 0) 
                    Y = STATE_1;
                else 
                    Y = STATE_2;
                z = 1;
            end
            STATE_4: begin
                if (x == 0) 
                    Y = STATE_3;
                else 
                    Y = STATE_4;
                z = 1;
            end
            default: begin
                Y = STATE_0;
                z = 0;
            end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            y <= STATE_0;
        else
            y <= Y;
    end
endmodule
