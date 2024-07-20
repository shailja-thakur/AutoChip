module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    localparam [2:0]
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011;

    reg [2:0] state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end

            STATE_B: begin
                if (r[1])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end

            STATE_C: begin
                if (r[2])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end

            STATE_D: begin
                if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end

            default: next_state = STATE_A;
        endcase
    end

    // Output logic (combinational logic)
    always @(*) begin
        case (state)
            STATE_B: g = 3'b001; // g1=1
            STATE_C: g = 3'b010; // g2=1
            STATE_D: g = 3'b100; // g3=1
            default: g = 3'b000; // g1=g2=g3=0
        endcase
    end

endmodule
